#!/usr/bin/env bash
#
# Dotfiles - Ubuntu installation script
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

# Update package list
update_packages() {
    log_info "Updating package list..."
    sudo apt-get update -qq
    log_success "Package list updated"
}

# Install package via apt (idempotent)
install_package() {
    local package="$1"

    if dpkg -l "$package" 2>/dev/null | grep -q "^ii"; then
        log_success "$package is already installed"
        return 0
    fi

    log_info "Installing $package..."
    sudo apt-get install -y -qq "$package"
    log_success "$package installed"
}

# Install essential packages
install_packages() {
    local packages=(
        zsh
        git
        curl
        wget
        build-essential
    )

    for package in "${packages[@]}"; do
        install_package "$package"
    done
}

main() {
    log_info "Starting Ubuntu configuration..."

    update_packages
    install_packages

    log_success "Ubuntu configuration complete!"
}

main "$@"
