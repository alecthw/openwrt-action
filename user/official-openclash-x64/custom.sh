#!/bin/bash

# Execute after install feeds
# patch -> [update & install feeds] -> custom -> config

echo "Execute custom custom.sh"

# change packages
rm -rf feeds/packages/net/mosdns
svn co https://github.com/QiuSimons/openwrt-mos/trunk/mosdns feeds/packages/net/mosdns
# use fork repo before PR accepted
sed -i 's/^PKG_VERSION.*/PKG_VERSION:=2f1bfed/g' feeds/packages/net/mosdns/Makefile
sed -i 's#IrineSistiana/mosdns/tar#alecthw/mosdns/tar#g' feeds/packages/net/mosdns/Makefile

rm -rf feeds/packages/net/smartdns
svn co https://github.com/Lienol/openwrt-packages/branches/master/net/smartdns feeds/packages/net/smartdns

rm -rf feeds/packages/net/zerotier
svn co https://github.com/coolsnowwolf/packages/trunk/net/zerotier feeds/packages/net/zerotier
