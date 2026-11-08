# Development Guidelines

## Communication

- Explain error messages in detail in Japanese.
- Keep technical terms and annotations like `TODO:` and `NOTE:` in English.

## Writing

Applies to documents and code comments. Commit messages and PR descriptions are written in English.

- Write natural Japanese. Avoid literal translations from English, coined words, and abstract metaphors (e.g. 「払った教訓」「今日の地図」「起点」「系列」「手組みリソース」「素タグ」). Before finishing, reread the text and ask whether a native speaker would actually phrase it that way.
- Spell out names in full instead of abbreviating (e.g. WIF, FIC, CL, sg).
- Do not use bold or emoji. Use backticks only for code.
- Explain in prose. Use bullet lists only for things that are genuinely a list.
- Do not put a space between alphanumeric characters and Japanese.
- Cut redundant or self-evident sentences.
- When given a reference document for tone and style, read it and match it.

## Where Information Belongs

Each kind of information has exactly one home ([t_wada](https://x.com/t_wada/status/904916106153828352)).

| Place         | Explains | Meaning                                   |
| ------------- | -------- | ----------------------------------------- |
| Code          | How      | The code itself is the explanation.       |
| Test code     | What     | What the code is supposed to do.          |
| Commit log    | Why      | Why the change was needed.                |
| Code comments | Why not  | Why the obvious alternative was rejected. |

- If code needs a comment to explain how it works, rewrite the code instead.
- Write comments for someone reading the file, not a reviewer reading the diff. Leave out change history (「〇〇に委譲」), PR numbers, and obvious section labels (`# タグ`), but keep context that cannot be recovered from the code.

## Development

- When changing the behavior of testable code, follow TDD (Red → Green → Refactor).
- Follow Tidy First: never mix structural and behavioral changes in one commit. Make the structural change first.
- When approaches compete, prioritize: testability > readability > consistency with existing code > simplicity > reversibility.
- Do not swallow exceptions. Catch a specific one only to add context, clean up, or recover.
- Write throwaway scripts in Ruby unless the project uses another language.
- Change only what the request covers. If something else needs fixing, propose it instead of changing it.
- Do not run `aws` commands yourself. They need special authentication, so ask the user to run them.
- If you have failed three times, stop and reassess the approach.

## Commits

- Commit only when tests pass with no warnings.
- Never use `--no-verify`. If a hook fails, fix the cause.
- If GPG signing fails, ask the user to unlock the key instead of skipping the signature.
- Keep each commit small. Write the message in English, usually as a subject line only.
- Use the Conventional Commits type to mark structural (`refactor:`) vs behavioral (`feat:` / `fix:`) changes.
- Add a body only when the why is not obvious, in a sentence or two. Background, alternatives, and follow-ups belong in the PR description.

## Pull Requests

- Create PRs as drafts.
- If the repository has a PR template, follow it.
- Otherwise, write it in English with Background, What this does, and Note, plus Alternatives considered when an alternative was weighed. A small change may need only What this does.
- Background says what is wrong today and why it matters, concretely, naming the PR or issue it came from. What this does says what changes and what the reader sees as a result. Note holds what could not be verified, what could go another way, and anything the reviewer should decide.
- Write each section as a few sentences of prose. Use bullets only when each item is an independent change, such as one entry per reworded string.
- One concern per PR. A cleanup noticed on the way becomes its own PR that names the one it came from.
- Keep the title short enough to convey what the PR does at a glance.
- When asked to reply to a PR or issue comment, draft the reply. Post it only when explicitly asked.
- Once a PR has review comments, add new commits instead of force pushing. When a force push is needed, use `--force-with-lease`.
