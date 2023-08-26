#!/bin/bash

# Execute after install feeds
# patch -> [update & install feeds] -> custom -> config

echo "Execute custom custom.sh"

# add luci-app-openclash
rm -rf package/luci-app-openclash
svn co -q https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
# download latest clash meta core
mkdir -p package/luci-app-openclash/root/etc/openclash/core
clash_meta_version=$(curl -kLs "https://api.github.com/repos/MetaCubeX/Clash.Meta/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')
echo "clash_meta_version: ${clash_meta_version}"
curl -kL --retry 3 --connect-timeout 3 -o package/luci-app-openclash/root/etc/openclash/core/clash_meta.gz https://github.com/MetaCubeX/Clash.Meta/releases/latest/download/clash.meta-linux-amd64-compatible-${clash_meta_version}.gz
gzip -d package/luci-app-openclash/root/etc/openclash/core/clash_meta.gz
chmod 755 package/luci-app-openclash/root/etc/openclash/core/clash_meta

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
