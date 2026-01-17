# Dotfiles

Personal configuration files for macOS and Ubuntu.

## Features

- **Oh My Zsh** - Zsh framework with plugins
- **Powerlevel10k** - Modern prompt with Git and AWS info
- **Idempotent** - Safe to run multiple times

## Quick Start

```bash
git clone https://github.com/viniciuscainelli/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## What's Included

### Plugins

| Plugin | Description |
|--------|-------------|
| git | Git aliases and functions |
| docker | Docker autocompletion |
| kubectl | Kubernetes autocompletion |
| aws | AWS CLI autocompletion and profile switching |
| history | History search improvements |
| sudo | Press ESC twice to add sudo |

### Prompt Info (Powerlevel10k)

- Git branch and status
- AWS profile
- Kubernetes context
- Command execution time
- Error codes

## Structure

```
dotfiles/
├── install.sh          # Main installation script
├── zsh/
│   └── .zshrc          # Zsh configuration
├── macos/
│   └── install.sh      # macOS dependencies (Homebrew)
└── ubuntu/
    └── install.sh      # Ubuntu dependencies (apt)
```

## Requirements

- macOS or Ubuntu
- Git
- curl

## Post-Installation

1. Restart your terminal
2. Run `p10k configure` to customize the prompt
3. Install a Nerd Font for icons (recommended):

```bash
# macOS
brew install --cask font-meslo-lg-nerd-font
```

## Local Configuration

Create `~/.zshrc.local` for machine-specific settings (not versioned).

## License

MIT
