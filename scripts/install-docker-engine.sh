#!/bin/bash

# Step 1: Update the package lists
# This command updates the list of available packages and their versions, but it does not install or upgrade any packages.
sudo apt-get update

# Step 2: Install necessary packages
# Install ca-certificates and curl packages. ca-certificates is needed for SSL-based applications to check for the authenticity of SSL connections. curl is a tool to transfer data from or to a server.
sudo apt-get install ca-certificates curl

# Step 3: Create the directory for storing the GPG key
# This command creates a directory at /etc/apt/keyrings if it doesn't already exist. The directory is used to store the GPG key for Docker.
sudo install -m 0755 -d /etc/apt/keyrings

# Step 4: Download Docker's official GPG key
# Download the GPG key from Docker's official website and save it to /etc/apt/keyrings/docker.asc. This key is used to verify the integrity of the Docker packages.
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Step 5: Set read permissions on the GPG key
# Modify the permissions of the docker.asc file to make it readable by anyone. This is necessary for apt to read and use the GPG key for verifying packages.
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Step 6: Add Docker's repository to APT sources
# This command constructs the repository line, including the architecture and the path to the GPG key, and adds it to /etc/apt/sources.list.d/docker.list. It ensures apt can find and install Docker packages from Docker's official repository.
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Step 7: Update the package lists again
# Finally, update the package lists again to include the newly added Docker repository. This makes sure that apt knows about the Docker packages available for installation.
sudo apt-get update

# Step 8: Install Docker and associated tools
# This command installs Docker Engine (docker-ce), the Docker CLI (docker-ce-cli), container runtime (containerd.io), and the plugins for Docker Buildx (docker-buildx-plugin) and Docker Compose (docker-compose-plugin). These components are essential for creating and managing Docker containers and Docker Compose for defining and running multi-container Docker applications.
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

