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

### Refresh the vendored git checkouts

powerlevel10k, zsh-autosuggestions, zsh-syntax-highlighting and (off macOS)
`~/.fzf` are declared in `.chezmoiexternal.toml` rather than cloned by the setup
script. `chezmoi apply` clones whichever are missing and `git pull`s the rest at
most once a week.

- Pull them now, ignoring that weekly limit: `chezmoi apply -R always`
- Never touch the network for them: `chezmoi apply -R never`
