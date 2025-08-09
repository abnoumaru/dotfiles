# Continue existing work

## Check existing branches
1. Run `git branch -a` to see all branches
2. Look for feature branches related to current work
3. If found, use `git checkout <branch-name>` instead of creating new branch

## When to create new branch
- No existing feature branch exists
- Work is completely unrelated to existing branches
- Previous work is completed and merged

## Examples
- If working on dotfiles improvements and `feature/dotfiles-*` exists → switch to it
- If adding new feature unrelated to existing branches → create new branch