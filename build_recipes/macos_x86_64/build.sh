#!/usr/bin/env zsh

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
cat 1>&2 << EOF
Usage: ./build.sh [--clean]
Pass --clean if to do a clean build starting from scratch

EOF
    exit
fi
[ "$1" = "--clean" ] && ls -l | grep ^d | awk "{print \"rm -rf \"\$NF}" 1>&2 | sh
[ ! -e ./rdkit_knime/bin/python ] && python3 -m venv rdkit_knime
. rdkit_knime/bin/activate
[ ! -e ./rdkit_knime/bin/ansible-playbook ] && pip install ansible
ansible-playbook --connection=local --limit 127.0.0.1 Ansible_playbook_macOS_x86_64.yml
