#!/usr/bin/env zsh

[ "$1" = "--clean" ] && ls -l | grep ^d | awk "{print \"rm -rf \"\$NF}" 1>&2 | sh
[ ! -e ./rdkit_knime/bin/python ] && python3 -m venv rdkit_knime
. rdkit_knime/bin/activate
[ ! -e ./rdkit_knime/bin/ansible-playbook ] && pip install ansible
ansible-playbook --connection=local --limit 127.0.0.1 Ansible_playbook_macOS_x86_64.yml
