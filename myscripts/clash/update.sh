#!/bin/sh

# use clash binary file
# you need put subscription in subscription.txt

value=`cat subscription.txt`
echo $value
mv ./config.yaml config_old.yaml &&
wget -O config.yaml "$value" # curl also could
