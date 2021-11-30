#!/bin/sh

sudo apt update

sudo apt install openssl nginx -y
mv -f /var/www/html/index.nginx-debian.html /var/www/html/index.html
sudo ufw allow 'Nginx HTTP'

sudo apt install curl jq nkf -y

cat > /var/www/html/status.json << ENDOFFILE
{
  "daipeg": true,
  "daiusd": "1",
  "lastupdate": "1637616949"
}
ENDOFFILE
