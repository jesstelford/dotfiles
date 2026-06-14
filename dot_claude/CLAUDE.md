# Global instructions for Claude Code

These apply across all repositories on my machines.

## Environment

- Primary OS is the latest macOS (Apple Silicon); I also keep things working on
  Ubuntu Linux.
- Shell is `zsh`. Editor is Neovim (LazyVim).
- Dotfiles are managed with [chezmoi](https://www.chezmoi.io/); files under the
  source directory are templates, so don't edit the deployed `~/.zshrc` etc.
  directly — change the chezmoi source.

## Tools to prefer

- Search with `rg` (ripgrep) and `fd`, not `grep -r` / `find`.
- View files with `bat` when a pager is helpful.
- Node version is managed by `fnm`; Python by `uv`.

## Working style

- Be concise. Lead with the answer, then the reasoning.
- Match the surrounding code's style; don't introduce new dependencies or
  patterns without a reason.
- Don't add comments that just restate what the code does.
- Ask before destructive or hard-to-reverse actions.
