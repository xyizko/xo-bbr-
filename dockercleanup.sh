#!/usr/bin/bash
set -euo pipefail

# Colors
RE='\033[0;31m'
PU='\033[0;35m'
NC='\033[0m'

# Banner
t1='
---
Executes the following - Destory all Docker containers
curl -L https://raw.githubusercontent.com/xyizko/xo-rel-s-rd/refs/heads/main/filez/docker_cleanup.sh | bash
---
'
b1() {
    clear
    echo -e "${RE}${t1}${NC}"
}
# Coms
e1() {
    echo -e "${PU}Running...${NC}"
    curl -L https://raw.githubusercontent.com/xyizko/xo-rel-s-rd/refs/heads/main/filez/docker_cleanup.sh | bash
}
# Execution
b1
e1
