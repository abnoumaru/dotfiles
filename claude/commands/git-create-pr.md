# Create PR

- Follow Read @.github/PULL_REQUEST_TEMPLATE.md
- Create as Draft
- Use `--set-upstream` when pushing: `git push -u origin <branch_name>`
- Determine PR title by:
  - Check all branch commits with `git log origin/main..HEAD`
  - Summarize the most important change if multiple changes exist
  - Use commit message if single commit
- Command example: `gh pr create --draft --title "title" --body "body"`