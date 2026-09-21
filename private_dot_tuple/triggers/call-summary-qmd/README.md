# Call Summary - qmd

A [Tuple](https://tuple.app) trigger that summarizes a finished call with [Claude
Code](https://claude.com/claude-code) and indexes it into [qmd](https://github.com/tobi/qmd) — a local
search engine over markdown — so past calls are searchable from the terminal alongside everything
else qmd indexes.

This is the same headless shape as `slack-call-summary-claude`, with the Slack delivery replaced by
local indexing. Nothing opens and nothing waits for input.

## What it does

When `call-capture-complete` fires, the trigger writes a prompt and launches Claude headless. The
event supplies the call id directly (`TUPLE_TRIGGER_CALL_ID`), so there's no need to guess which
call just finished. Claude then:

- Reads the transcript — `tuple capture show <id>`.
- Writes a title and a structured summary (outcome, decisions, action items, open questions, notable
  context) back onto the call with `tuple call edit <id> --title ... --summary ...`, so they show up
  in Tuple's Call History.

`call-capture-complete` fires once per recording session, not once per call — capture can stop and
restart within a call, and each session fires its own completion event. Every firing re-reads and
re-summarizes the *whole* call and overwrites the existing title/summary, so a restart's summary
reflects everything captured so far rather than going stale. The trade-off: a title/summary you
wrote by hand in Tuple's UI will be overwritten by the next automated run on that call — there is no
reliable way to tell a hand-edit apart from a prior automated pass.

The trigger then exports every call's title and summary to markdown and hands them to qmd:

```bash
qmd query "what did we decide about rate limiting" -c tuple
qmd search "postgres migration" -c tuple
```

## Summaries, not transcripts

Only titles and summaries are indexed. A raw transcript is mostly filler and cross-talk, and it
captures whatever personal conversation happened around the work — the summary is the part worth
searching. Full transcripts stay one command away:

```bash
tuple capture show <call-id>
```

Everything stays on your machine: Tuple transcribes on-device, qmd indexes and embeds locally, and
the exported summaries are plain markdown you can read or delete.

## Requirements

- macOS
- The `tuple` CLI available on your login shell's `PATH` (with `capture` and `call edit` support —
  Tuple 3.3+; the equivalent commands were named `transcription ...` before that)
- [Claude Code](https://claude.com/claude-code) (`claude`), authenticated
- [qmd](https://github.com/tobi/qmd) — optional. Without it the summary is still written to the
  call and only the indexing step is skipped.

## Setup

Install the trigger. There is no other setup: on its first run it registers the qmd collection and
sets that collection's update command, so `qmd update` keeps it current from then on.

Claude Code is given a deliberately narrow allow-list — only `tuple capture show` and
`tuple call edit`, the subcommands needed to read the call and write the summary back.

## Configuration

| Variable | Default | Purpose |
| --- | --- | --- |
| `TUPLE_QMD_OUT` | `$XDG_DATA_HOME/tuple-summaries` (`~/.local/share/tuple-summaries`) | Where the exported markdown lives |
| `CALL_SUMMARY_QMD_COLLECTION` | `tuple` | Name of the qmd collection |
| `CALL_SUMMARY_QMD_DRY_RUN` | unset | Set to `1` to write the prompt and exit without running Claude |

## Troubleshooting

The trigger logs to `/tmp/tuple-trigger-debug.log`; each run also keeps its prompt and Claude's
output under `$TMPDIR/tuple-call-summary-qmd/`.

- **Nothing happens when a call ends.** Triggers must be enabled in Tuple, which registers a
  Background Item. Check with
  `launchctl print gui/$(id -u)/app.tuple.app.triggers >/dev/null 2>&1 && echo ON || echo OFF`.
- **`claude not found on login-shell PATH`.** Triggers run from a Background Item with a minimal
  environment, so the work is re-launched through a login shell. Make sure `claude`, `tuple` and
  `qmd` all work in a fresh terminal.
- **The call is indexed as "Untitled call".** The summary was not readable yet when the export ran.
  The next `qmd update` repairs it.
- **`TUPLE_TRIGGER_CALL_ID not set; ... refusing to guess which call this is`.** The trigger relies on
  Tuple's `call-capture-complete` event supplying `TUPLE_TRIGGER_CALL_ID` (and
  `TUPLE_TRIGGER_RECORDING_ID`), per `tuple agent guide automation`. If a future Tuple version stops
  supplying it, this trigger needs updating again rather than falling back to a guess.
