#!/bin/bash
sudo apt update
sudo apt-get install -y apache2
sudo systemctl enable apache2
sudo systemctl start apache2
