#!/bin/bash

# Update the system package list
sudo apt-get update

# Installation of necessary tools
sudo apt-get install -y wget

# Get the latest version of Go
LATEST_GO_VERSION=$(wget -qO- https://go.dev/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1 | grep -oP 'go[0-9\.]+' | sed 's/\.$//')

# Download the latest version of Go
wget "https://dl.google.com/go/$LATEST_GO_VERSION.linux-amd64.tar.gz"

# Delete the old version (if it exists)
sudo rm -rf /usr/local/go

# Extract to /usr/local
sudo tar -C /usr/local -xzf "$LATEST_GO_VERSION.linux-amd64.tar.gz"

# Setting environment variables
echo "export PATH=$PATH:/usr/local/go/bin" >> "$HOME/.profile"

# Delete the downloaded zip file
rm "$LATEST_GO_VERSION.linux-amd64.tar.gz"

# Reload .profile for root's shell
source $HOME/.profile

# Verify the installation
go version

echo "Go installation complete!"
