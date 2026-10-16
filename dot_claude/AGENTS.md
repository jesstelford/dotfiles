# Global agent instructions

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

## Secrets

- Never print a secret into your context: no `echo`, `cat` or `printf` of
  values from a secret store, `.env` file or credentials API. Anything a tool
  prints stays in the transcript and cannot be redacted.
- Keep a secret in a shell variable or pipe it between commands inside a single
  invocation. To compare or check one, print only a non-reversible derivation —
  a truncated `shasum -a 256`, a length, an equality boolean, a status code.
- When a secret has to be handled, prefer writing a script I run myself.

## Posting under my name

`gh`, and any other tool authenticated as me, publishes what you write as if I
wrote it.

- End every GitHub comment, review body, review-thread reply, and edit of one,
  with this line, after a blank line, verbatim:

  ```html
  <div align="right"><sup>— Posted by Claude</sup></div>
  ```

  Readers otherwise reply to it as my own words. PR and issue descriptions you
  create carry the `🤖 Generated with [Claude Code]` footer instead; don't add
  both. If a comment went out without the byline, edit it rather than posting a
  follow-up. Skip it for non-prose actions (labels, merges) and for text I
  dictate as my own.
- Lead with the finding, not the method. Aim for roughly 500–600 words for a
  substantial PR description and 150–250 for a comment; expect to cut a first
  draft by half. Others read these, and length buries the decisions they have
  to act on.
- Hit the length by cutting content, never by compressing grammar. Write
  ordinary complete sentences, short to medium; dropped articles and clauses
  stacked behind dashes read as noise even when every fact is there.
- State why each change exists and what breaks without it; leave how to the
  diff. A reviewer can read the code but not your reasoning.
- Use dot points over paragraphs. Keep every number, security callout and
  deploy consequence; cut filler, hedging, and narration of how you researched
  it.
- Spell out coinages and shorthand from your own analysis. Precise domain terms
  stay.
- Link the evidence behind each claim — the dashboard behind a number, the past
  PRs the work builds on, vendor docs, commit SHAs, `file:line` — so the reader
  can check it.

## Writing deliverables

- State facts as they are now. Leave out the document's own history ("an
  earlier draft said", "corrected after review"); a reader has to work out
  which claim is live. Keep evidence strength — verified, inferred, could not
  verify.
- When the deliverable is a set of rules (a skill, a standard, a checklist),
  write each as an imperative and drop the corpus and counts it was derived
  from. Keep a rule's reason when it changes how the rule is applied. An agent
  reading an observation has to infer the instruction before acting on it.

## Subagents

- When launching a subagent on a non-default model, make its first output line
  its exact model id, and check it. Passing the model parameter is not proof it
  applied, and a silent fallback defeats the reason for choosing the model.

## Shell and background jobs

- Use `zsh -lic`, not `zsh -lc`, to get my normal `PATH` in a non-interactive
  context. zsh reads `~/.zshrc` only for interactive shells, and that is where
  `PATH` is extended; the harmless `can't change option: zle` warning without a
  tty is expected.
- Test what a background job (launchd, cron, a trigger) can see with `env -i`.
  A probe from an ordinary shell inherits its `PATH` and passes falsely.
- Install long-lived Node CLIs outside fnm's per-version directories, e.g.
  `npm install -g --prefix ~/.local`. For a background job that needs `node`,
  put `~/.fnm/aliases/default/bin` on `PATH`, never a
  `~/.local/state/fnm_multishells/*` path. Version directories disappear when a
  Node version is removed, and multishell paths are per-shell.

## qmd, Logseq and Tuple

- Read Logseq notes from the markdown mirror
  (`~/Logseq/graphs/*/mirror/markdown/`) or search them with qmd; don't parse
  `db.sqlite`.
- qmd's `the tensor API is not supported in this environment` warning on Apple
  Silicon is benign — Metal still works. Don't investigate it.
- Tuple triggers are folders under `~/.tuple/triggers/<name>/`: a `config.json`
  plus an executable named after each event. They run with a bare environment,
  so set `PATH` explicitly and detach long work with `nohup … &`, or the hook
  holds Tuple open.
