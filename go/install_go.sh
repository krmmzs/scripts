#!/bin/bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to handle errors
handle_error() {
    log_error "An error occurred in script at line: ${1}"
    cleanup
    exit 1
}

log_info "Starting Go installation process..."

# Update the system package list
log_info "Updating package list..."
if sudo apt-get update; then
    log_info "Package list updated successfully"
else
    log_error "Failed to update package list"
    exit 1
fi

# Installation of necessary tools
log_info "Installing necessary tools (wget)..."
if sudo apt-get install -y wget; then
    log_info "wget installed successfully"
else
    log_error "Failed to install wget"
    exit 1
fi

# Get the latest version of Go
set +e
log_info "Fetching latest Go version information..."
LATEST_GO_VERSION=$(wget -qO- https://go.dev/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1 | grep -oP 'go[0-9\.]+' | sed 's/\.$//')
if [ -z "$LATEST_GO_VERSION" ]; then
    log_error "Failed to determine latest Go version"
    exit 1
fi
set -e

# 添加超时和更详细的错误处理
if ! LATEST_GO_VERSION=$(timeout 30 wget -qO- https://go.dev/dl/ 2>/dev/null | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1 | grep -oP 'go[0-9\.]+' | sed 's/\.$//' 2>/dev/null); then
    log_error "Failed to fetch Go version information from https://go.dev/dl/"
    log_error "This could be due to:"
    log_error "  - Network connectivity issues"
    log_error "  - go.dev website being unavailable"
    log_error "  - Changes in the website structure"
    exit 1
fi

log_info "Latest Go version found: $LATEST_GO_VERSION"

# Download the latest version of Go
log_info "Downloading $LATEST_GO_VERSION..."
if wget "https://dl.google.com/go/$LATEST_GO_VERSION.linux-amd64.tar.gz"; then
    log_info "Go tarball downloaded successfully"
else
    log_error "Failed to download Go tarball"
    exit 1
fi

# Delete the old version (if it exists)
if [ -d "/usr/local/go" ]; then
    log_warn "Removing existing Go installation at /usr/local/go"
    sudo rm -rf /usr/local/go
    log_info "Old Go installation removed"
else
    log_info "No existing Go installation found"
fi

# Extract to /usr/local
log_info "Extracting Go to /usr/local..."
if sudo tar -C /usr/local -xzf "$LATEST_GO_VERSION.linux-amd64.tar.gz"; then
    log_info "Go extracted successfully"
else
    log_error "Failed to extract Go tarball"
    exit 1
fi

# Setting environment variables
log_info "Setting up environment variables..."
if ! grep -q "/usr/local/go/bin" "${HOME}/.profile" 2>/dev/null; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> "${HOME}/.profile"
    log_info "Added Go to PATH in ~/.profile"
else
    log_warn "Go PATH already exists in ~/.profile"
fi

# Delete the downloaded zip file
log_info "Cleaning up downloaded tarball..."
rm "$LATEST_GO_VERSION.linux-amd64.tar.gz"

# Reload .profile for current shell if it exists
log_info "Reloading environment variables..."
if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
    log_info "Environment variables reloaded"
else
    log_warn "~/.profile not found, PATH updated for current session"
    export PATH=$PATH:/usr/local/go/bin
fi

# Verify the installation
log_info "Verifying Go installation..."
if command -v go &> /dev/null; then
    GO_VERSION=$(go version)
    log_info "Go installation verified: $GO_VERSION"
else
    log_error "Go command not found after installation"
    exit 1
fi

log_info "Go installation completed successfully!"
log_info "You may need to restart your terminal or run 'source ~/.profile' to use Go in new sessions"
