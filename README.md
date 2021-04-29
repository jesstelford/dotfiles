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

## Save changes

1. Edit the file (eg; `echo "echo 'hi'" >> ~/.zshrc`)
2. Tell chezmoi about the changes: `chezmoi add ~/.zshrc`
    * Automatically pushes the changes to this repo
