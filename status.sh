#!/bin/bash -e

while true; do
    daiusd="$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=dai&vs_currencies=usd" | jq -r '.dai.usd')"
    if [ ${daiusd%%.*} -ge "1" ]; then
       contents="$(jq '.daipeg = true' /var/www/html/status.json)" && \
       echo "${contents}" > /var/www/html/status.json
       contents="$(mlq '#daipeg = "✅ Yes"' /var/www/html/index.html)" && \
       echo "${contents}" > /var/www/html/index.html
       else
          contents="$(jq '.daipeg = false' /var/www/html/status.json)" && \
          echo "${contents}" > /var/www/html/status.json
          contents="$(mlq '#daipeg = "❌ No"' /var/www/html/index.html)" && \
          echo "${contents}" > /var/www/html/index.html
fi
    contents="$(jq ".daiusd = \"$daiusd\"" /var/www/html/status.json)" && \
    echo "${contents}" > /var/www/html/status.json
    contents="$(mlq "#daiusd = \"$daiusd\"" /var/www/html/index.html)" && \
    echo "${contents}" > /var/www/html/index.html

    recentlyupdatedat=$(date +"%s")
    contents="$(jq ".lastupdate = \"$recentlyupdatedat\"" /var/www/html/status.json)" && \
    echo "${contents}" > /var/www/html/status.json

    contents=$(jq -r '.lastupdate' /var/www/html/status.json)
    contentstwo=$(date -d @${contents})
    contentsthree="$(mlq "#lastupdate = \"${contentstwo}\"" /var/www/html/index.html)" && \
    echo "${contentsthree}" > /var/www/html/index.html
    sleep 300
done
