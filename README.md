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

1. Edit the file (eg; `echo "echo 'hi'" >> ~/.zshrc`)
2. Show diff of what's changed: `chezmoi diff --recursive --exclude scripts --reverse`
3. Add the changes to chezmoi: `chezmoi add -p $(chezmoi diff --recursive --exclude scripts --reverse | lsdiff | cut -c2- | sed -e 's/^/~/' | tr '\n' ' ')`
   - Automatically pushes the changes to this repo

### Update machine with latest from chezmoi

1. Get the latest changes: `chezmoi git pull`
2. See what's changed: `chezmoi diff -r -x scripts`
3. Apply changes: `chezmoi apply -r -x scripts`

### Re-run scripts

1. Get the latest changes: `chezmoi git pull`
2. See the scripts that will be run: `chezmoi diff -r -i scripts`
3. Re-run scripts: `chezmoi apply -i scripts`

### Refresh the vendored git checkouts

powerlevel10k, zsh-autosuggestions, zsh-syntax-highlighting and (off macOS)
`~/.fzf` are declared in `.chezmoiexternal.toml` rather than cloned by the setup
script. `chezmoi apply` clones whichever are missing and `git pull`s the rest at
most once a week.

- Pull them now, ignoring that weekly limit: `chezmoi apply -R always`
- Never touch the network for them: `chezmoi apply -R never`
