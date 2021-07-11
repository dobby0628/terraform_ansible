#!/bin/bash
sudo yum install -y httpd
sudo echo "test page1" >> /var/www/html/index.html
sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl stop firewalld
