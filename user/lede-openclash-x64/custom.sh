#!/bin/bash

# Execute after install feeds
# patch -> [update & install feeds] -> custom -> config

echo "Execute custom custom.sh"

# add luci-app-openclash
rm -rf package/luci-app-openclash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

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
sed -i 's/^PKG_VERSION.*/PKG_VERSION:=2f1bfed/g' feeds/packages/net/mosdns/Makefile
sed -i 's#IrineSistiana/mosdns/tar#alecthw/mosdns/tar#g' feeds/packages/net/mosdns/Makefile

cat package/lean/default-settings/files/zzz-default-settings
