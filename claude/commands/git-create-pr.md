# Create PR

- Follow Read @.github/PULL_REQUEST_TEMPLATE.md
- Create as Draft
- Use `--set-upstream` when pushing: `git push -u origin <branch_name>`
- Determine PR title by:
  - Check all branch commits with `git log origin/main..HEAD --oneline`
  - **Include all commits in title consideration, not just the latest**
  - Summarize the overall branch purpose if multiple different changes exist
  - Use commit message if single focused change
  - Ensure title reflects the complete scope of work in the branch
- Command example: `gh pr create --draft --title "title" --body "body"`