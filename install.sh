#!/usr/bin/env bash
#
# Dotfiles - Main installation script
# Compatible with macOS and Ubuntu
# Idempotent: can be run multiple times without side effects
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect operating system
detect_os() {
    case "$(uname -s)" in
        Darwin)
            echo "macos"
            ;;
        Linux)
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                if [ "$ID" = "ubuntu" ] || [ "$ID_LIKE" = "debian" ]; then
                    echo "ubuntu"
                else
                    echo "linux"
                fi
            else
                echo "linux"
            fi
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

# Install Oh My Zsh (idempotent)
install_oh_my_zsh() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        log_success "Oh My Zsh is already installed"
        return 0
    fi

    log_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log_success "Oh My Zsh installed successfully"
}

# Create symlink (idempotent)
create_symlink() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ]; then
        local current_source
        current_source=$(readlink "$target")
        if [ "$current_source" = "$source" ]; then
            log_success "Symlink already exists: $target -> $source"
            return 0
        else
            log_warning "Existing symlink points elsewhere: $target -> $current_source"
            rm "$target"
        fi
    elif [ -f "$target" ]; then
        log_warning "Existing file found: $target"
        local backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
        mv "$target" "$backup"
        log_info "Backup created: $backup"
    fi

    ln -s "$source" "$target"
    log_success "Symlink created: $target -> $source"
}

# Set Zsh as default shell (idempotent)
set_default_shell() {
    local zsh_path
    zsh_path=$(which zsh)

    if [ "$SHELL" = "$zsh_path" ]; then
        log_success "Zsh is already the default shell"
        return 0
    fi

    log_info "Setting Zsh as default shell..."

    # Add zsh to /etc/shells if not already there
    if ! grep -q "$zsh_path" /etc/shells; then
        echo "$zsh_path" | sudo tee -a /etc/shells > /dev/null
    fi

    chsh -s "$zsh_path"
    log_success "Zsh set as default shell"
}

# Run OS-specific script
run_os_script() {
    local os="$1"
    local script="$DOTFILES_DIR/$os/install.sh"

    if [ -f "$script" ]; then
        log_info "Running $os specific script..."
        bash "$script"
    else
        log_warning "OS specific script not found: $script"
    fi
}

main() {
    log_info "Starting dotfiles installation..."
    log_info "Directory: $DOTFILES_DIR"

    local os
    os=$(detect_os)
    log_info "Detected operating system: $os"

    if [ "$os" = "unknown" ]; then
        log_error "Unsupported operating system"
        exit 1
    fi

    # Run OS-specific installation (installs dependencies)
    run_os_script "$os"

    # Install Oh My Zsh
    install_oh_my_zsh

    # Create symlinks
    create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

    # Set Zsh as default shell
    set_default_shell

    echo ""
    log_success "Installation complete!"
    log_info "Restart your terminal or run: source ~/.zshrc"
}

main "$@"
