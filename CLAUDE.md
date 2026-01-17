# Dotfiles

Personal configuration files for macOS and Ubuntu.

## Structure

```
dotfiles/
├── install.sh          # Main installation script
├── zsh/                # Zsh and Oh My Zsh configurations
│   └── .zshrc
├── macos/              # macOS specific scripts
└── ubuntu/             # Ubuntu specific scripts
```

## Requirements

- macOS or Ubuntu
- Git
- curl or wget

## Installation

```bash
git clone https://github.com/cainelli-inc/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Components

### Oh My Zsh

Framework for managing Zsh configuration.

- Website: https://ohmyz.sh/
- Automatic installation via script

## Development

### Useful commands

```bash
# Test installation
./install.sh

# Apply zsh configuration only
source ~/.zshrc
```

### Notes for Claude

- Keep compatibility between macOS and Ubuntu
- Installation scripts must be idempotent
- Use Oh My Zsh as the shell framework
- **All commits, code, and comments must be in English**
- **Communication with the user should be in Brazilian Portuguese**
