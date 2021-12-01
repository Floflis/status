#!/bin/sh

sh ./update-site.sh

sudo apt update

sudo apt install curl jq nkf -y

cat > /var/www/html/status.json << ENDOFFILE
{
  "daipeg": true,
  "daiusd": "1",
  "lastupdate": "1637616949"
}
ENDOFFILE
