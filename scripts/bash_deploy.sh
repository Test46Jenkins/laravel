#!/bin/bash
cd /home/ec2-user/apps
composer install
npm install
sudo chown -R ec2-user:ec2-user /home/ec2-user/apps
