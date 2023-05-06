#!/bin/bash

# Execute after install feeds
# patch -> [update & install feeds] -> custom -> config

echo "Execute custom custom.sh"

# add luci-app-openclash
rm -rf package/luci-app-openclash
svn co -q https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

# replace luci-app-smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
git clone --depth=1 https://github.com/pymumu/luci-app-smartdns.git feeds/luci/applications/luci-app-smartdns

# replace smartdns
rm -rf feeds/packages/net/smartdns
svn co -q https://github.com/Lienol/openwrt-packages/branches/master/net/smartdns feeds/packages/net/smartdns

# add luci-app-mosdns
rm -rf package/luci-app-mosdns
svn co -q https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns package/luci-app-mosdns

# replace mosdns
rm -rf feeds/packages/net/mosdns
svn co -q https://github.com/QiuSimons/openwrt-mos/trunk/mosdns feeds/packages/net/mosdns
# use fork repo before PR accepted
sed -i 's/^PKG_VERSION.*/PKG_VERSION:=2f1bfed/g' feeds/packages/net/mosdns/Makefile
sed -i 's#IrineSistiana/mosdns/tar#alecthw/mosdns/tar#g' feeds/packages/net/mosdns/Makefile

# add luci-app-zerotier
rm -rf package/luci-app-zerotier
svn co -q https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-zerotier package/luci-app-zerotier

# replace zerotier
rm -rf feeds/packages/net/zerotier
svn co -q https://github.com/coolsnowwolf/packages/trunk/net/zerotier feeds/packages/net/zerotier

# add luci-app-vlmcsd vlmcsd
rm -rf package/luci-app-vlmcsd package/vlmcsd
svn co -q https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-vlmcsd package/luci-app-vlmcsd
svn co -q https://github.com/coolsnowwolf/packages/trunk/net/vlmcsd package/vlmcsd
