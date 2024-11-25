#!/usr/bin/bash

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Variables
t1='
---
This will run the following commands
# Build Docker Image
DOCKER_BUILDKIT=1 docker build -t recon-tools .
# Run Docker Container
docker run --rm -v $(pwd)/results:/app/results -e TARGET=example.com recon-tools
Results will be stored in ./results
--
'

# Banner Functions
xo() {
    url="https://snips.sh/f/ZuwtQ3Pk0x?r=1"
    curl $url
}
b1() {
    clear
    echo -e "${BLUE}${t1}${NC}"
}

e1() {
    local tar1=$1
    # Ensure the results directory exists and has the correct permissions
    mkdir -p results
    chmod -R 777 results
    # Execution of command
    echo -e "${GREEN}${tar1}${NC}"
    DOCKER_BUILDKIT=1 docker build -t recon-tools .
    docker run --rm -v $(pwd)/results:/app/results -e TARGET=${tar1} recon-tools
}

# Check if a target domain is provided
if [ -z "$1" ]; then
    echo -e "${RED}NO DOMAIN SUPPLIED${NC}"
    echo "Usage: $0 <target-domain>"
    exit 1
fi

# Execution
xo
b1
e1 "$1"