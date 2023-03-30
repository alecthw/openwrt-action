#!/bin/bash

# Execute before update feeds
# patch -> [update & install feeds] -> custom -> config

echo "Execute custom patch.sh"

# add custom packages
rm -rf package/luci-app-mosdns
svn co https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns package/luci-app-mosdns

rm -rf package/luci-app-smartdns
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns

rm -rf package/luci-app-openclash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

rm -rf package/luci-app-vlmcsd package/vlmcsd
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-vlmcsd package/luci-app-vlmcsd
svn co https://github.com/coolsnowwolf/packages/trunk/net/vlmcsd package/vlmcsd

svn co package/luci-app-zerotier
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-zerotier package/luci-app-zerotier
