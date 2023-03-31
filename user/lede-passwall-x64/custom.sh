#!/bin/bash

# Execute after install feeds
# patch -> [update & install feeds] -> custom -> config

echo "Execute custom custom.sh"

# add luci-app-smartdns
rm -rf package/luci-app-smartdns
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns

# replace smartdns
rm -rf feeds/packages/net/smartdns
svn co https://github.com/Lienol/openwrt-packages/branches/master/net/smartdns feeds/packages/net/smartdns

# replace luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
svn co https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns feeds/luci/applications/luci-app-mosdns

# replace mosdns
rm -rf feeds/packages/net/mosdns
svn co https://github.com/QiuSimons/openwrt-mos/trunk/mosdns feeds/packages/net/mosdns
# use fork repo before PR accepted
sed -i 's/^PKG_VERSION.*/PKG_VERSION:=088bf91/g' feeds/packages/net/mosdns/Makefile
sed -i 's#IrineSistiana/mosdns/tar#alecthw/mosdns/tar#g' feeds/packages/net/mosdns/Makefile

# replace dns2socks
rm -rf feeds/packages/net/dns2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/dns2socks feeds/packages/net/dns2socks

# replace microsocks
rm -rf feeds/packages/net/microsocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/microsocks feeds/packages/net/microsocks

# replace pdnsd-alt
rm -rf feeds/packages/net/pdnsd-alt
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/pdnsd-alt feeds/packages/net/pdnsd-alt

cat package/lean/default-settings/files/zzz-default-settings
