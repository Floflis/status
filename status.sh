#!/bin/bash -e

while true; do
    daiusd="$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=dai&vs_currencies=usd" | jq -r '.dai.usd')"
    if [ ${daiusd%%.*} -ge "1" ]; then
       contents="$(jq '.daipeg = true' status.json)" && \
       echo "${contents}" > status.json
       else
          contents="$(jq '.daipeg = false' status.json)" && \
          echo "${contents}" > status.json
fi
    contents="$(jq ".daiusd = \"$daiusd\"" status.json)" && \
    echo "${contents}" > status.json
    recentlyupdatedat=$(date +"%s")
    contents="$(jq ".lastupdate = \"$recentlyupdatedat\"" status.json)" && \
    echo "${contents}" > status.json
    sleep 300
done
