# dotfiles

macOS dotfiles repository using symbolic links and [mise](https://mise.jdx.dev/) task runner.

## Prerequisites

1. Install Command Line Tools: `xcode-select --install`
2. Install Homebrew: https://brew.sh
3. Install mise: `curl https://mise.run | sh`

## Quick Start

```bash
mise run all    # run all setup tasks
mise tasks      # show available tasks
```

## Directory Structure

| Directory | Description |
|-----------|-------------|
| `bin/` | Personal scripts (linked to ~/bin/) |
| `claude/` | Claude Code configuration |
| `git/` | Git configuration template |
| `karabiner/` | Keyboard remapping |
| `mise/` | Tool version management |
| `neovim/` | Editor configuration |
| `postgres/` | psqlrc configuration |
| `scripts/` | System setup scripts |
| `starship/` | Shell prompt |
| `vscode/` | VS Code settings |
| `wezterm/` | Terminal emulator |
| `zsh/` | Shell configuration |

## References

- https://zenn.dev/botamotch/articles/e7960f0dc84d8b
- https://gist.github.com/sheepla/d680f1480d8c36c4290d6aabebf1abc6
- https://zenn.dev/monica/articles/81c8f632b72584
- https://zenn.dev/nokogiri/articles/ec99e40df54555
- https://zenn.dev/mozumasu/articles/mozumasu-wezterm-customization
