#!/bin/bash

# This script executes two other scripts: script1.sh and script2.sh

echo "Installing Docker Engine... "
./scripts/install-docker-engine.sh

echo "Adding User to Docker Group... "
./scripts/add-user-to-docker-group.sh

echo "Docker Installed Successfully!"
