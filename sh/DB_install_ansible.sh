#!/bin/bash
cd /ansible/
ansible-playbook --limit 'db' ./playbook/Database

