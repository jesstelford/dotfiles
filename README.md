`dotfiles` managed by [chezmoi](https://www.chezmoi.io/)

## Install

```sh
# Install chezmoi & dotfiles
sh -c "$(curl -fsLS git.io/chezmoi)" -- init jesstelford

# See what'll get run
chezmoi -vn apply

# Actually run it
chezmoi -v apply
```

One liner:

```sh
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply jesstelford
```

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
