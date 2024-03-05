#!/bin/bash

# Step 1: Add the current user to the docker group
# Adding the user to the docker group allows the user to execute Docker commands without prefixing them with sudo.
sudo usermod -aG docker $USER

# Step 2: Grant the current user root privileges
# This step is generally achieved by adding the user to the 'sudo' group or editing the sudoers file. Here, we add the user to the 'sudo' group.
# Note: This script assumes that the system uses a sudo group to manage sudo privileges, which is common in many Linux distributions.
sudo usermod -aG sudo $USER

# Optional: Inform the user that they might need to log out and back in for the changes to take effect.
echo "You may need to log out and log back in for the group changes to take effect."
