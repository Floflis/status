#!/bin/sh

sudo apt update

sudo apt install openssl nginx -y
cp site/* /var/www/html
rm -rf site
rm -f /var/www/html/index.nginx-debian.html
sudo ufw allow 'Nginx HTTP'

sudo apt install curl jq nkf -y

sudo chown -R $USER:$USER /var/www

cat > /var/www/html/status.json << ENDOFFILE
{
  "daipeg": true,
  "daiusd": "1",
  "lastupdate": "1637616949"
}
ENDOFFILE
