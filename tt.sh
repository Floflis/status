#!/bin/bash -e

while true; do
    if [ "$(jq -r '.daipeg' status.json)" = "false" ]; then
       if [ ! -f daipeg.broken ]; then
          touch daipeg.broken
          # tweet "Dai USD peg is temporarily broken! 1 DAI = $(jq -r '.daiusd' status.json) USD"
fi
       else
          if [ -f daipeg.broken ]; then echo "tweet Dai USD peg has been restored! 1 DAI = $(jq -r '.daiusd' status.json) USD"; rm -f daipeg.broken; fi
fi
    sleep 300
done
