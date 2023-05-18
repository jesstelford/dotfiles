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

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

# +x is to detect an empty env var: https://stackoverflow.com/a/13864829
if [ -z "${CODESPACES+x}" ] || [ -z "${CI+x}" ] || [ -z "${SPIN+x}" ]; then
  # --no-tty because we can't do anything interactive in these environments
  chezmoi_args="--no-tty"
else
  # --apply because we want to ensure we're actually doing the setup
  chezmoi_args=""
fi

set -- init --apply --source="${script_dir}" ${chezmoi_args}

unset chezmoi_args

echo "Running 'chezmoi $*'" >&2
# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
