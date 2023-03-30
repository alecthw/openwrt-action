#!/bin/bash

# Execute before update feeds
# patch -> [update & install feeds] -> custom -> config

echo "Execute custom patch.sh"

# add custom packages
rm -rf package/luci-app-smartdns
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns
