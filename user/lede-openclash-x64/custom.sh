#!/bin/bash

# Execute after install feeds

echo "Execute custom custom.sh"

# change packages
rm -rf feeds/packages/net/smartdns
svn co https://github.com/Lienol/openwrt-packages/branches/main/net/smartdns feeds/packages/net/smartdns

cat package/lean/default-settings/files/zzz-default-settings