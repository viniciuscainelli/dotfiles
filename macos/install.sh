#!/usr/bin/env bash
#
# Dotfiles - macOS installation script
# Idempotent: can be run multiple times without side effects
#

set -e

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

# Install Xcode Command Line Tools (idempotent)
install_xcode_cli() {
    if xcode-select -p &> /dev/null; then
        log_success "Xcode Command Line Tools already installed"
        return 0
    fi

    log_info "Installing Xcode Command Line Tools..."
    xcode-select --install

    # Wait for installation
    until xcode-select -p &> /dev/null; do
        sleep 5
    done

    log_success "Xcode Command Line Tools installed"
}

# Install Homebrew (idempotent)
install_homebrew() {
    if command -v brew &> /dev/null; then
        log_success "Homebrew is already installed"
        return 0
    fi

    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for current session
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    log_success "Homebrew installed successfully"
}

# Install packages via Homebrew (idempotent)
install_packages() {
    local packages=(
        zsh
        git
        curl
        wget
    )

    for package in "${packages[@]}"; do
        if brew list "$package" &> /dev/null; then
            log_success "$package is already installed"
        else
            log_info "Installing $package..."
            brew install "$package"
            log_success "$package installed"
        fi
    done
}

main() {
    log_info "Starting macOS configuration..."

    install_xcode_cli
    install_homebrew
    install_packages

    log_success "macOS configuration complete!"
}

main "$@"
