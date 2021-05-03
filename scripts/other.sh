#!/bin/bash

# install nginx
sudo amazon-linux-extras install nginx1 -y

# Enable and start the nginx service
sudo systemctl enable nginx
sudo systemctl start nginx

# do some other stuff