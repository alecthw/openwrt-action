#!/bin/bash

# Execute after install feeds
# patch -> [update & install feeds] -> custom -> config

echo "Execute custom custom.sh"

# add luci-app-openclash
rm -rf package/luci-app-openclash
svn co -q https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
# download latest clash meta core
clash_meta_version=$(curl -kLs "https://api.github.com/repos/MetaCubeX/Clash.Meta/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')
echo "clash_meta_version: ${clash_meta_version}"
curl -kL --retry 3 --connect-timeout 3 -o package/luci-app-openclash/root/etc/openclash/core/clash_meta.gz https://github.com/MetaCubeX/Clash.Meta/releases/latest/download/clash.meta-linux-amd64-compatible-${clash_meta_version}.gz
gzip -d package/luci-app-openclash/root/etc/openclash/core/clash_meta.gz
chmod 755 package/luci-app-openclash/root/etc/openclash/core/clash_meta

# add luci-app-smartdns
rm -rf package/luci-app-smartdns
git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns

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
sed -i 's/^PKG_VERSION.*/PKG_VERSION:=2f1bfed/g' feeds/packages/net/mosdns/Makefile
sed -i 's#IrineSistiana/mosdns/tar#alecthw/mosdns/tar#g' feeds/packages/net/mosdns/Makefile

cat package/lean/default-settings/files/zzz-default-settings
