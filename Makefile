DOTFILES_DIR := $(shell pwd)

all: brew wezterm neovim starship zsh gitconfig mise karabiner vscode postgres macos bin claude claude_commands

brew:
	@echo "Setting up Homebrew..."
	ln -sf $(DOTFILES_DIR)/Brewfile $(HOME)/Brewfile
	brew bundle

brew_dump:
	@echo "Dumping the current Brewfile..."
	brew bundle dump --force

wezterm:
	@echo "Setting up WezTerm..."
	mkdir -p $(HOME)/.config/wezterm
	ln -sf $(DOTFILES_DIR)/wezterm/wezterm.lua $(HOME)/.config/wezterm/wezterm.lua

neovim:
	@echo "Setting up Neovim..."
	mkdir -p $(HOME)/.config/nvim
	ln -sf $(DOTFILES_DIR)/neovim/init.lua $(HOME)/.config/nvim/init.lua

starship:
	@echo "Setting up Starship..."
	ln -sf $(DOTFILES_DIR)/starship/starship.toml $(HOME)/.config/starship.toml

zsh:
	@echo "Setting up ZSH..."
	ln -sf $(DOTFILES_DIR)/zsh/.zshrc $(HOME)/.zshrc
	chmod 755 /opt/homebrew/share

gitconfig:
	@echo "Setting up Git..."
	mkdir -p $(HOME)/go/src
	@read -p "Enter your name: " name; \
	read -p "Enter your email: " email; \
	sed -e "s/Hoge Fuga/$$name/" -e "s/hoge@example.com/$$email/" -e "s/hogehogehoge/$$USER/" $(DOTFILES_DIR)/git/gitconfig.template > $(HOME)/.gitconfig

mise:
	@echo "Setting up mise..."
	ln -sf $(DOTFILES_DIR)/mise/.tool-versions $(HOME)/.tool-versions

karabiner:
	@echo "Setting up Karabiner-Elements..."
	ln -sf $(DOTFILES_DIR)/karabiner/karabiner.json $(HOME)/.config/karabiner/karabiner.json

vscode:
	@echo "Setting up Visual Studio Code..."
	ln -sf $(DOTFILES_DIR)/vscode/settings.json $(HOME)/Library/Application\ Support/Code/User/settings.json

postgres:
	@echo "Setting up postgres..."
	ln -sf $(DOTFILES_DIR)/postgres/.psqlrc $(HOME)/.psqlrc

macos:
	@echo "Applying macOS system defaults..."
	sh -x $(DOTFILES_DIR)/scripts/macos.sh

bin:
	@echo "Setting up personal commands..."
	mkdir -p $(HOME)/bin
	@for file in $(DOTFILES_DIR)/bin/*; do \
		if [ -f "$$file" ] && [ -x "$$file" ] && [ "$$(basename $$file)" != "README.md" ]; then \
			echo "Linking $$(basename $$file)..."; \
			ln -sf "$$file" "$(HOME)/bin/$$(basename $$file)"; \
		fi; \
	done

claude:
	@echo "Setting up Claude configuration..."
	mkdir -p $(HOME)/.claude
	ln -sf $(DOTFILES_DIR)/claude/CLAUDE.md $(HOME)/.claude/CLAUDE.md

claude_commands:
	@echo "Setting up Claude commands..."
	mkdir -p $(HOME)/.claude/commands
	@for file in $(DOTFILES_DIR)/claude/commands/*.md; do \
		if [ -f "$$file" ]; then \
			echo "Linking $$(basename $$file)..."; \
			ln -sf "$$file" "$(HOME)/.claude/commands/$$(basename $$file)"; \
		fi; \
	done

help:
	@echo "make targets available:"
	@echo "  all"
	@echo "  brew"
	@echo "  brew_dump"
	@echo "  wezterm"
	@echo "  neovim"
	@echo "  starship"
	@echo "  zsh"
	@echo "  gitconfig"
	@echo "  mise"
	@echo "  karabiner"
	@echo "  vscode"
	@echo "  postgres"
	@echo "  macos"
	@echo "  bin"
	@echo "  claude"
	@echo "  claude_commands"

.PHONY: all brew brew_dump wezterm neovim starship raycast zsh gitconfig mise vscode karabiner postgres macos bin claude claude_commands help
