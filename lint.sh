#!/bin/bash
set -euo pipefail

# Run ansible-lint across all playbooks
ansible-lint

# Syntax check each playbook
shopt -s nullglob
for playbook in *.yml; do
    echo "Syntax checking: $playbook"
    ansible-playbook --syntax-check -i localhost, "$playbook"
done
