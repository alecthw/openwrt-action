#!/bin/bash

# Execute after install feeds
# patch -> [update & install feeds] -> custom -> config

echo "Execute custom custom.sh"

# replace luci-app-smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns.git feeds/luci/applications/luci-app-smartdns

# replace smartdns
rm -rf feeds/packages/net/smartdns
svn co -q https://github.com/Lienol/openwrt-packages/branches/master/net/smartdns feeds/packages/net/smartdns

# replace luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
svn co -q https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns feeds/luci/applications/luci-app-mosdns

# replace mosdns
rm -rf feeds/packages/net/mosdns
svn co -q https://github.com/QiuSimons/openwrt-mos/trunk/mosdns feeds/packages/net/mosdns
# use fork repo before PR accepted
sed -i 's/^PKG_VERSION.*/PKG_VERSION:=fa4996c/g' feeds/packages/net/mosdns/Makefile
sed -i 's#IrineSistiana/mosdns/tar#alecthw/mosdns/tar#g' feeds/packages/net/mosdns/Makefile

# replace dns2socks
rm -rf feeds/packages/net/dns2socks
svn co -q https://github.com/xiaorouji/openwrt-passwall/trunk/dns2socks feeds/packages/net/dns2socks

# replace microsocks
rm -rf feeds/packages/net/microsocks
svn co -q https://github.com/xiaorouji/openwrt-passwall/trunk/microsocks feeds/packages/net/microsocks

# replace pdnsd-alt
rm -rf feeds/packages/net/pdnsd-alt
svn co -q https://github.com/xiaorouji/openwrt-passwall/trunk/pdnsd-alt feeds/packages/net/pdnsd-alt

cat package/lean/default-settings/files/zzz-default-settings
