#!/bin/bash
cd /tf/1-openstack
terraform init
terraform apply -auto-approve
cp /tf/4_image.tf /tf/1-openstack/
terraform apply -auto-approve
cp /tf/5_orchestration.tf /tf/1-openstack/
terraform apply -auto-approve
