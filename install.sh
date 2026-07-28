#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
set -eu

if ! chezmoi="$(command -v chezmoi)"; then
  bin_dir="${HOME}/.local/bin"
  chezmoi="${bin_dir}/chezmoi"
  echo "Installing chezmoi to '${chezmoi}'" >&2
  
  if command -v curl >/dev/null; then
    chezmoi_install_script="$(curl -fsSL https://chezmoi.io/get)"
  elif command -v wget >/dev/null; then
    chezmoi_install_script="$(wget -qO- https://chezmoi.io/get)"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
  
  sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
  
  unset chezmoi_install_script bin_dir chezmoi_args
fi

# POSIX way to get the script's dir: https://stackoverflow.com/a/29834779/12156188
#
# `command -v -- "$0"` resolves $0 through $PATH, which is what makes this work
# when the script is invoked by bare name. But under `curl -fsSL ... | sh` there
# is no script file at all: $0 is the shell ("sh"), `command -v sh` answers
# /bin/sh, and this used to hand chezmoi `--source=/bin`. /bin is a real,
# readable directory, so nothing complained -- chezmoi just took an empty source
# directory and applied nothing.
#
# So resolve it, then only trust the answer if the directory it lands in
# actually looks like THIS chezmoi source directory.
script_dir=""
resolved_self="$(command -v -- "$0" 2>/dev/null || true)"
# `command -v` only answers for things it considers executable, so an explicit
# `sh install.sh` of a non-executable copy gets nothing back. Fall back to $0
# when it actually names a file -- under `curl | sh` it names the shell, not a
# file, so this stays empty there.
if [ -z "${resolved_self}" ] && [ -f "$0" ]; then
  resolved_self="$0"
fi
if [ -n "${resolved_self}" ] && [ -f "${resolved_self}" ]; then
  candidate="$(cd -P -- "$(dirname -- "${resolved_self}")" 2>/dev/null && pwd -P)" || candidate=""
  if [ -n "${candidate}" ] && [ -f "${candidate}/.chezmoi.toml.tmpl" ]; then
    script_dir="${candidate}"
  fi
fi

# This test was inverted: it read `[ -z "${VAR+x}" ]`, which is true when VAR is
# UNSET, and the two halves were OR'd. So `--no-tty` was applied on exactly the
# local machines that still had to answer the `promptString`s in
# .chezmoi.toml.tmpl, and was NOT applied in the two non-interactive
# environments it exists for.
#
# `${VAR:-}` + `-n` is "set and non-empty", which is deliberately the same
# question .chezmoi.toml.tmpl asks (`env "CODESPACES" | not | not`). The old
# `${VAR+x}` form asked "is it set at all", so a `CI=` in the environment would
# have suppressed the TTY here while the config template still went looking for
# interactive answers.
if [ -n "${CODESPACES:-}" ] || [ -n "${CI:-}" ]; then
  # --no-tty because we can't do anything interactive in these environments
  chezmoi_args="--no-tty"
else
  chezmoi_args=""
fi

if [ -n "${script_dir}" ]; then
  set -- init --apply --source="${script_dir}" ${chezmoi_args}
else
  echo "Warning: could not locate the chezmoi source directory from \$0 ('$0')." >&2
  echo "         Falling back to chezmoi's own default source directory." >&2
  set -- init --apply ${chezmoi_args}
fi

unset chezmoi_args candidate resolved_self

echo "Running 'chezmoi $*'" >&2
# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
