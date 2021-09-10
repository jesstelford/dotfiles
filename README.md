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
2. Show what's changed: `chezmoi diff -r -x scripts` (_NOTE: diff is inversed_)
3. Add the changes to chezmoi: `chezmoi add ~/.zshrc ~/.foo`
   - Automatically pushes the changes to this repo

### Update machine with latest from chezmoi

1. Get the latest changes: `chezmoi git pull`
2. See what's changed: `chezmoi diff -r -x scripts`
3. Apply changes: `chezmoi apply -r -x scripts`

### Re-run scripts

1. Get the latest changes: `chezmoi git pull`
2. See the scripts that will be run: `chezmoi diff -r -i scripts`
3. Re-run scripts: `chezmoi apply -i scripts`
