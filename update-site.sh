#!/bin/sh

sudo apt install openssl nginx -y
cp site/* /var/www/html
rm -rf site
rm -f /var/www/html/index.nginx-debian.html
#sudo ufw app list
sudo ufw allow 'Nginx HTTP'
#sudo ufw allow 'Nginx HTTPS'
#ufw allow OpenSSH
#ufw enable
#sudo ufw status
#systemctl status nginx

sudo chown -R $USER:$USER /var/www

#ufw status
#ufw allow OpenSSH
#ufw enable

#adduser  --gecos GECOS
#usermod -aG sudo 
