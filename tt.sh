#!/bin/bash -e

while true; do
    if [ "$(jq -r '.daipeg' status.json)" = "false" ]; then
       if [ ! -f daipeg.broken ]; then
          touch daipeg.broken
          echo "Dai USD peg is temporarily broken! 1 DAI = $(jq -r '.daiusd' status.json) USD" | ./tweet.sh post
fi
       else
          if [ -f daipeg.broken ]; then echo "Dai USD peg has been restored! 1 DAI = $(jq -r '.daiusd' status.json) USD" | ./tweet.sh post; rm -f daipeg.broken; fi
fi
    sleep 300
done
