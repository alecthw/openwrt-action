#!/bin/bash

echo "Execute custom patch.sh"

# add custom packages
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns

# --------------- mini
# passwall
#rm -rf package/lean/dns2socks
#rm -rf package/lean/ipt2socks
rm -rf package/lean/kcptun
rm -rf package/lean/microsocks
#rm -rf package/lean/pdnsd-alt
#rm -rf package/lean/shadowsocksr-libev
#rm -rf package/lean/simple-obfs
rm -rf package/lean/trojan
#rm -rf package/lean/v2ray
#rm -rf package/lean/v2ray-plugin
# --------------- mini
