#!/bin/sh

sudo apt install openssl nginx -y
cp site/* /var/www/html
rm -rf site
rm -f /var/www/html/index.nginx-debian.html
sudo ufw allow 'Nginx HTTP'

sudo chown -R $USER:$USER /var/www
