#!/bin/bash
Sudo chown -R ec2-user:ec2-user /home/ec2-user/apps
cd /home/ec2-user/apps
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo yum install -y nodejs
sudo chown -R ec2-user:ec2-user /home/ec2-user/apps
composer install
npm install