#!/bin/bash -e

while true; do
    daiusd="$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=dai&vs_currencies=usd" | jq -r '.dai.usd')"
    if [ ${daiusd%%.*} -ge "1" ]; then
       contents="$(jq '.daipeg = true' /var/www/html/status.json)" && \
       echo "${contents}" > /var/www/html/status.json
       sed -i -e 's|<element id="daipeg">\([0-9]\{0,\}\)</element>|<element id="daipeg">'"✅ Yes"'</element>|g' /var/www/html/index.html
       else
          contents="$(jq '.daipeg = false' /var/www/html/status.json)" && \
          echo "${contents}" > /var/www/html/status.json
          sed -i -e 's|<element id="daipeg">\([0-9]\{0,\}\)</element>|<element id="daipeg">'"❌ No"'</element>|g' /var/www/html/index.html
fi
    contents="$(jq ".daiusd = \"$daiusd\"" /var/www/html/status.json)" && \
    echo "${contents}" > /var/www/html/status.json
    recentlyupdatedat=$(date +"%s")
    contents="$(jq ".lastupdate = \"$recentlyupdatedat\"" /var/www/html/status.json)" && \
    echo "${contents}" > /var/www/html/status.json
    sed -i -e 's|<element id="daiusd">\([0-9]\{0,\}\)</element>|<element id="daiusd">'"${daiusd}"'</element>|g' /var/www/html/index.html
    contents=$(jq -r '.lastupdate' /var/www/html/status.json)
    sed -i -e 's|<element id="lastupdate">\([0-9]\{0,\}\)</element>|<element id="lastupdate">'"$(date -d @${contents})"'</element>|g' /var/www/html/index.html
    sleep 300
done
