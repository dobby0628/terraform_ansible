#!/bin/bash
cd /ansible/
ansible-playbook --limit '!db' ./playbook/tomcat_war.yaml

