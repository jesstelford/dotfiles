`dotfiles` managed by [chezmoi](https://www.chezmoi.io/)

## Install

On a brand new machine, this is the only command you need:

```sh
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply jesstelford
```

**`--apply` is the part that installs anything.** Without it, `init` clones this
repo to `~/.local/share/chezmoi`, asks the three email questions, writes
`~/.config/chezmoi/chezmoi.toml`, and exits 0 — having changed nothing in `$HOME`
and having run no setup scripts. That looks like a silent failure, but it's
`init` doing its whole job.

The run is interactive. Expect:

1. Three prompts for emails (git, 1Password, lock screen) — these get stored in
   `~/.config/chezmoi/chezmoi.toml`.
2. Your sudo password and a RETURN, for the Homebrew install.
3. A `y`/`n` prompt for each optional setup step.

Already ran `init` without `--apply`? Don't re-init — just run `chezmoi apply`.

### Previewing before you apply

```sh
chezmoi -vn apply --no-pager   # see what'll get run
chezmoi -v apply               # actually run it
```

`--no-pager` matters on a fresh machine: this config sets `bat` as the diff
pager, but `bat` isn't installed until the first real `apply` runs the setup
scripts.

## Workflow

### Tell Chezmoi about changes

**This repo is public.** Adding is deliberately one named file at a time, and
publishing is a separate step.

1. Edit the file (eg; `echo "echo 'hi'" >> ~/.zshrc`)
2. See what differs: `chezmoi diff --recursive --exclude scripts --reverse`
3. Add each file you actually want published, **by name**: `chezmoi add ~/.zshrc`
   - `autoCommit` is on, so this writes a local commit for you
4. Read that commit before it leaves the machine: `chezmoi git -- log -1 -p`
5. Publish it: `chezmoi git -- push`

`autoPush` is deliberately **off**. A local commit is revocable; a push to a
public repo is not — force-pushing does not remove the objects, GitHub keeps
orphaned commits reachable by SHA through the API. So the push stays a separate,
deliberate act.

This section used to recommend a one-liner that piped the whole `chezmoi diff`
through `lsdiff` into a single bulk `chezmoi add`. That's gone on purpose:
adding a computed list you haven't read is the habit that publishes a credential
in one command. `.chezmoiignore` carries a secrets deny-list (`.ssh`, `.aws`,
`.netrc`, `*.pem`, …) as a second line of defence, but a deny-list only knows
the names it was given. If something genuinely secret has to be managed, add it
with `chezmoi add --encrypt`.

### Update machine with latest from chezmoi

1. Get the latest changes: `chezmoi git pull`
2. See what's changed: `chezmoi diff -r -x scripts`
3. Apply changes: `chezmoi apply -r -x scripts`

### Re-run scripts

1. Get the latest changes: `chezmoi git pull`
2. See the scripts that will be run: `chezmoi diff -r -i scripts`
3. Re-run scripts: `chezmoi apply -i scripts`

### Setup scripts

The install steps live in `.chezmoiscripts/`, one file per domain, run in
numeric order before anything else is applied:

| Script | Covers |
| --- | --- |
| `00-homebrew` | Homebrew itself (macOS) |
| `10-dev-deps` | base build/dev packages |
| `20-shell` | zsh, git-absorb, git-lfs, ripgrep, fzf |
| `30-editors` | Neovim |
| `40-desktop` | Brave, Rust, emoji picker, Roam, FontForge, fonts |
| `50-languages` | fnm, Node, yarn |
| `60-cli-tools` | tmux, bat, eza, fd, delta, uv, language servers, … |
| `70-dev-tools` | KeyCastr, gh, MongoDB, DBeaver, Go |
| `80-apps` | 1Password, Signal, PICO-8, Rectangle, Discord, mkcert, … |
| `90-macos-defaults` | `defaults write` system settings |
| `99-finalise` | zsh permissions fixup and the closing banner |

Living in `.chezmoiscripts/` keeps them out of `$HOME`: chezmoi runs them but
never writes them to a target path.

Most are `run_onchange_`, so chezmoi re-runs a script only when *that* script's
rendered contents change — bumping the Neovim version in `.chezmoidata.toml` no
longer replays 60 install steps. `00-homebrew` and `90-macos-defaults` are
`run_once_` instead, because they are once-per-machine bootstraps rather than
things to re-apply.

Helpers every script needs (`runner`, `optional_runner`, `apt_get`,
`install_dmg`, `use_temp_dir`, `verify_sha256`) live in
`.chezmoitemplates/setup-helpers.sh.tmpl`, and the closing "what failed"
summary in `.chezmoitemplates/setup-summary.sh.tmpl`; each script is its own
bash process, so both have to be included in each one. That is also what makes
a failure re-run only its own domain: chezmoi records a `run_onchange_` script
as done only when it exits 0.

Numbering goes up in tens so a new step can be slotted in without renaming
everything. Order matters in places: Node before the npm-installed tooling, and
the 1Password CLI before PICO-8 reads its itch.io credentials with `op`.

### Refresh the vendored git checkouts

powerlevel10k, zsh-autosuggestions, zsh-syntax-highlighting and (off macOS)
`~/.fzf` are declared in `.chezmoiexternal.toml` rather than cloned by the setup
scripts. `chezmoi apply` clones whichever are missing and `git pull`s the rest at
most once a week.

- Pull them now, ignoring that weekly limit: `chezmoi apply -R always`
- Never touch the network for them: `chezmoi apply -R never`
