# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles repository that manages configuration files and system setup through symbolic links and Make targets. The repository uses a centralized configuration approach where all dotfiles are maintained in this directory and linked to their appropriate system locations.

## Common Commands

### Initial Setup
```bash
make all  # Complete system setup (requires Homebrew and CommandLineTools)
```

### Individual Component Setup
```bash
make brew          # Install packages via Homebrew bundle
make brew_dump     # Update Brewfile with currently installed packages
make wezterm       # Link WezTerm configuration
make neovim        # Link Neovim configuration  
make starship      # Link Starship prompt configuration
make zsh           # Link ZSH configuration
make gitconfig     # Setup Git configuration (interactive - prompts for name/email)
make mise          # Link mise tool versions
make karabiner     # Link Karabiner-Elements key mapping
make vscode        # Link VS Code settings
make postgres      # Link PostgreSQL configuration
make macos         # Apply macOS system defaults
make bin           # Link personal commands to ~/bin/
make claude        # Link Claude configuration to ~/.claude/
make help          # Show available targets
```

## Architecture

### Configuration Management
- **Symbolic Links**: All configurations use `ln -sf` to create symbolic links from this repository to system locations
- **Template System**: Git configuration uses a template (`git/gitconfig.template`) with placeholder replacement
- **Homebrew Bundle**: Package management through `Brewfile` with lock file tracking

### Directory Structure
- `wezterm/` - Terminal emulator configuration
- `neovim/` - Text editor configuration
- `starship/` - Shell prompt configuration  
- `zsh/` - Shell configuration
- `git/` - Git configuration template
- `mise/` - Development tool version management
- `karabiner/` - Keyboard remapping configuration
- `vscode/` - Editor settings
- `postgres/` - Database client configuration
- `scripts/` - System setup scripts
- `bin/` - Personal command scripts (linked individually to ~/bin/)
- `claude/` - Claude Code configuration

### Tool Versions
The repository manages development tools through mise (`.tool-versions`):
- AWS CLI tools (saml2aws, awscli)
- Kubernetes tools (kubectl, kubie, helm, helmfile)
- Infrastructure tools (terraform, sops, stern)

### macOS Integration
The `scripts/macos.sh` script configures system preferences:
- Finder settings (show hidden files)
- Dock behavior (auto-hide)
- Keyboard repeat rates
- Screenshot save location