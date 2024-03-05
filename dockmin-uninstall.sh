#!/bin/bash

# Function to print errors
print_error() {
    echo "ERROR: $1" >&2
}

# Function to print information
print_info() {
    echo "INFO: $1"
}

print_info "Starting Docker uninstallation process."

# Uninstall Docker packages
if sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli; then
    print_info "Docker packages uninstalled successfully."
else
    print_error "Failed to uninstall Docker packages."
    exit 1
fi

if sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce; then
    print_info "Removed unused Docker packages."
else
    print_error "Failed to remove unused Docker packages."
    exit 1
fi

# Remove Docker’s data directories and files
if sudo rm -rf /var/lib/docker /etc/docker; then
    print_info "Removed Docker's data directories."
else
    print_error "Failed to remove Docker's data directories."
fi

if sudo rm /etc/apparmor.d/docker; then
    print_info "Removed Docker's apparmor profile."
else
    print_error "Failed to remove Docker's apparmor profile or file does not exist."
fi

if sudo groupdel docker; then
    print_info "Removed 'docker' group."
else
    print_error "Failed to remove 'docker' group or group does not exist."
fi

if sudo rm -rf /var/run/docker.sock; then
    print_info "Removed Docker socket file."
else
    print_error "Failed to remove Docker socket file or file does not exist."
fi

# Optionally remove Docker's GPG key and APT repo
# Note: Adjust the grep pattern if needed to correctly identify the Docker GPG key
key=$(apt-key list | grep Docker | grep -B 1 "pub" | head -n 1 | awk '{print $2}')
if [ ! -z "$key" ] && sudo apt-key del "$key"; then
    print_info "Removed Docker's GPG key."
else
    print_error "Failed to remove Docker's GPG key or key does not exist."
fi

if sudo rm /etc/apt/sources.list.d/docker.list; then
    print_info "Removed Docker's APT repository."
else
    print_error "Failed to remove Docker's APT repository or file does not exist."
fi

print_info "Docker uninstallation process completed."
