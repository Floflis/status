#!/bin/bash -e

while true; do
    daiusd="$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=dai&vs_currencies=usd" | jq -r '.dai.usd')"
    if [ ${daiusd%%.*} -ge "1" ]; then
       contents="$(jq '.daipeg = true' /var/www/html/status.json)" && \
       echo "${contents}" > /var/www/html/status.json
       else
          contents="$(jq '.daipeg = false' /var/www/html/status.json)" && \
          echo "${contents}" > /var/www/html/status.json
fi
    contents="$(jq ".daiusd = \"$daiusd\"" /var/www/html/status.json)" && \
    echo "${contents}" > /var/www/html/status.json
    recentlyupdatedat=$(date +"%s")
    contents="$(jq ".lastupdate = \"$recentlyupdatedat\"" /var/www/html/status.json)" && \
    echo "${contents}" > /var/www/html/status.json
    sleep 300
done
