DOTFILES_DIR := $(shell pwd)

all: brew wezterm neovim starship zsh gitconfig mise macos

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

macos:
	@echo "Applying macOS system defaults..."
	sh -x $(DOTFILES_DIR)/scripts/macos.sh

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
	@echo "  macos"

.PHONY: all brew brew_dump wezterm neovim starship raycast zsh gitconfig mise macos help
