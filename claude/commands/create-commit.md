# Create commit message

## Prerequisites

- Confirm if TODO.md is included in the commit
- Always verify before committing:
  - Code compiles successfully
  - All tests pass
  - New features include tests
  - Code follows project formatter/linter rules

## Steps
1. Check files with `git status`
2. Run formatter/linter
3. Self-review changes
4. Create commit following [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

## Format specification
- Follow type(scope): subject format
- Title within 50 chars, body wrapped at 72 chars
- Use imperative verbs (add, fix, update, etc.)
- Include scope when appropriate, may omit if none fits
- Start commit messages with lowercase
- Explain "why" the change was made
