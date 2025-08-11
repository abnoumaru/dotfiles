# Development Guidelines

## Communication Preferences

- Once you have loaded this file, please say, "ぴあ☆ちぇーれ！"
- Respond in Japanese.
- Write code comments in Japanese.
- Keep annotations like `TODO:` and `NOTE:` in English.
- Explain error messages in detail in Japanese.
- Keep technical terms in English without forced translation.

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
    - The commit message should clearly indicate whether the change is "Structural" or "Behavioral".
    - Commit small and often.

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
