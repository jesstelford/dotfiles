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

## What gets installed

A full `chezmoi apply` provisions everything below. Two things narrow that list
on any given machine:

- **Platform** — anything tagged *(macOS)* or *(Linux)* is only installed there.
- **`.islocalenv`** — every GUI app, and most of the desktop tooling around it,
  is gated on being a real desktop, so Codespaces and CI get the CLI half only.

Steps tagged *(optional)* are the ones the run stops to ask `y`/`n` about.
Declining any of them is safe.

### Bootstrap

- [chezmoi](https://www.chezmoi.io/) — installs itself, via the one-liner above
- [Homebrew](https://brew.sh/) *(macOS)*

### Shell

- [zsh](https://www.zsh.org/) — and set as the login shell
- [powerlevel10k](https://github.com/romkatv/powerlevel10k) — prompt theme
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [fzf](https://junegunn.github.io/fzf/) — brew on macOS, a vendored checkout
  plus a downloaded binary everywhere else
- [tmux](https://tmux.github.io/)
- [cmux](https://www.cmux.dev/) *(macOS)* — terminal built around coding agents

### Git

- [git](https://git-scm.com/) — latest, from the `git-core` PPA on Linux
- [git-absorb](https://github.com/tummychow/git-absorb)
- [Git LFS](https://git-lfs.com/) — not optional; `.gitconfig` declares
  `required = true`, so git hard-fails on an LFS clone without it
- [delta](https://dandavison.github.io/delta/) — diff pager
- [GitHub CLI](https://cli.github.com/), plus the
  [gh-dash](https://github.com/dlvhdr/gh-dash) extension

### Command line

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [bat](https://github.com/sharkdp/bat)
- [eza](https://eza.rocks/) — the `ls` alias uses it, and falls back to system
  `ls` when it is absent
- [wget](https://www.gnu.org/software/wget/)
- [GNU parallel](https://savannah.gnu.org/projects/parallel/)
- [patchutils](https://cyberelk.net/tim/software/patchutils/) — for `lsdiff`
- [coreutils](https://www.gnu.org/software/coreutils/),
  [findutils](https://www.gnu.org/software/findutils/) and
  [tree](https://oldmanprogrammer.net/source.php?dir=projects/tree) *(macOS)*

### Editor

- [Neovim](https://neovim.io/) — the pinned release, plus a
  `/usr/local/bin/nvim` shim that pins `TERM` for tmux
- [neovim](https://github.com/neovim/node-client) npm package — for LazyVim

### Languages and runtimes

- [fnm](https://github.com/Schniz/fnm) and [Node.js](https://nodejs.org/)
- [Yarn](https://yarnpkg.com/) *(optional)*
- [TypeScript](https://www.typescriptlang.org/) — `tsc` on the command line;
  the language server is Mason's job
- [Go](https://go.dev/) — deliberately unpinned
- [Rust](https://rustup.rs/), via rustup
- [uv](https://docs.astral.sh/uv/) — Python

### Language servers and formatters

Only the ones useful outside Neovim. Mason owns the rest, driven by the extras
in `dot_config/nvim/lazyvim.json`.

- [lua-language-server](https://luals.github.io)
- [vscode-langservers-extracted](https://github.com/hrsh7th/vscode-langservers-extracted)
  — html, css, json, eslint
- [prettierd](https://github.com/fsouza/prettierd)

### Agents and search

- [Claude Code](https://claude.com/claude-code)
- [ant](https://github.com/anthropics/anthropic-cli) — CLI for the Claude
  platform
- [qmd](https://github.com/tobi/qmd) *(macOS)* — on-device search over the
  Logseq mirror and Tuple call summaries, kept fresh by a launchd agent

### Databases

- [MongoDB](https://www.mongodb.com/) *(Linux, optional)*
- [DBeaver](https://dbeaver.io/) *(optional)*

### Apps

- [Ghostty](https://ghostty.org/) *(macOS)* — the terminal, and where the
  `xterm-ghostty` terminfo the `nvim` shim names comes from
- [Brave](https://brave.com/)
- [1Password](https://1password.com/) *(optional)* and the
  [1Password CLI](https://developer.1password.com/docs/cli/) *(optional)*
- [Signal](https://signal.org/) *(optional)*
- [Discord](https://discord.com/) *(optional)*
- [Roam Research](https://roamresearch.com/) *(optional)*
- [Rectangle](https://rectangleapp.com/) *(macOS)* — window manager
- [AltTab](https://alt-tab.app/) *(macOS)* — window switcher
- [Karabiner-Elements](https://karabiner-elements.pqrs.org/) *(macOS)* — key
  remapping
- [KeyCastr](https://github.com/keycastr/keycastr) *(macOS)* — keypress
  visualiser
- [LICEcap](https://www.cockos.com/licecap/) *(macOS)* — screen capture to GIF
- [Rocket](https://matthewpalmer.net/rocket/) *(macOS)* /
  [Emote](https://github.com/tom-james-watson/Emote) *(Linux)* — emoji picker
- [Xournal++](https://xournalpp.github.io/) *(Linux)* — PDF annotation and
  handwritten notes
- [pdftk](https://gitlab.com/pdftk-java/pdftk) *(optional)*
- [PICO-8](https://www.lexaloffle.com/pico-8.php) *(optional)* — pulled from
  itch.io with credentials read out of 1Password by `op`
- [Wally](https://www.zsa.io/wally) *(optional)* — flashing tool for the ZSA
  Moonlander, plus the udev rules it needs on Linux
- [mkcert](https://github.com/FiloSottile/mkcert) *(optional)* — localhost TLS

### Fonts

- [FontForge](https://fontforge.org/) — headless only, to run the patcher below
- [Nerd Fonts](https://www.nerdfonts.com/) `font-patcher`, sparse-checked-out to
  `~/dev/nerd-fonts`
- [Input Mono](https://input.djr.com/), patched into a Nerd Font for
  powerlevel10k
- [Lato](https://fonts.google.com/specimen/Lato) and
  [Open Sans](https://fonts.google.com/specimen/Open+Sans) — for the Roam theme
- [Noto Color Emoji](https://github.com/googlefonts/noto-emoji) *(Linux)*

### Supporting packages

Installed because something above needs them, not for their own sake:
[nss](https://firefox-source-docs.mozilla.org/security/nss/index.html) (macOS) /
`libnss3-tools` (Linux) for mkcert, [libusb](https://libusb.info/) for Wally,
`libfuse2` for the Neovim AppImage, and `curl`, `gnupg`, `lsb-release`,
`software-properties-common`, `unzip` and `apt-transport-https` on Linux.

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
