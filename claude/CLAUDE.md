# Development Guidelines

## Communication Preferences

- Keep annotations like `TODO:` and `NOTE:` in English.
- Explain error messages in detail in Japanese.
- Keep technical terms in English without forced translation.

## Where Information Belongs

Each kind of information has exactly one home. Do not duplicate it elsewhere.
ref: https://x.com/t_wada/status/904916106153828352

| Place         | Explains    | Meaning                                           |
| ------------- | ----------- | ------------------------------------------------- |
| Code          | **How**     | How it works — the code itself is the explanation. |
| Test code     | **What**    | What the code is supposed to do.                  |
| Commit log    | **Why**     | Why the change was needed.                        |
| Code comments | **Why not** | Why the obvious alternative was rejected.         |

- If code needs a comment to explain *how* it works, rewrite the code instead.
- If a commit message explains *what* changed, delete it — the diff already says that.

## Core Principles

- **TDD & Tidy First**: Strictly follow Kent Beck's principles of Test-Driven Development (TDD) and Tidy First.
- **Incremental Progress**: Make small, incremental changes that compile and pass tests, rather than big bangs.
- **Learn from Existing Code**: Before implementing, study and understand the existing codebase to maintain consistency.
- **Clarity Over Cleverness**: Prefer boring, obvious code where the intent is clear over clever solutions.

## Development Workflow: The TDD Cycle

Always follow the **Red → Green → Refactor** cycle.

1.  **Red**: Write a single failing test that defines a small increment of functionality.
2.  **Green**: Write the minimum amount of code necessary to make the test pass.
3.  **Refactor**: With all tests passing (Green), refactor the code to eliminate duplication and improve clarity.

## The Tidy First Approach

Clearly separate all changes into two distinct types:

- **Structural Changes**: Reorganize code without changing its behavior (e.g., renaming, extracting methods, organizing dependencies).
- **Behavioral Changes**: Add or modify functionality.

Never mix these two types of changes in a single commit. If both are needed, always perform the structural changes first, ensure all tests pass, and then proceed with the behavioral changes.

## Quality Standards

- **Tests**:
    - All changes must be tested.
    - Test behavior, not implementation details.
    - Tests should be deterministic.
- **Code**:
    - Always follow the project's formatting and linting rules.
    - Make dependencies explicit.
    - Keep methods small and focused on a single responsibility.
- **Commits**:
    - Only commit when all tests are passing and there are no warnings.
    - Commit small and often.
    - Write commit messages in English.
    - Keep the message terse. For most changes the subject line is the whole message.
    - Write a body only when the **Why** is not obvious from the subject. Keep it to a sentence or two.
    - Do not write PR-level content in a commit: background, design rationale, alternatives considered, migration notes, or follow-up work. Those go in a PR description, a doc, or an issue.
    - Indicate Structural vs Behavioral through the Conventional Commits type (`refactor:` for structural, `feat:` / `fix:` for behavioral) rather than a line of prose.

## Decision-Making Framework

When multiple valid approaches exist, evaluate and choose based on the following order:

1.  **Testability**: Can this change be easily tested?
2.  **Readability**: Will someone else understand this in 6 months?
3.  **Consistency**: Does this match existing patterns in the project?
4.  **Simplicity**: Is this the simplest solution that works?
5.  **Reversibility**: How easy is it to change in the future?

## Important Reminders

**NEVER**:
- Use `--no-verify` to bypass commit hooks.
- Disable tests instead of fixing them.
- Commit code that doesn't compile.

**ALWAYS**:
- Commit working code incrementally.
- Stop and reassess your approach if you've failed three times.
