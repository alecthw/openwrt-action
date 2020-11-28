#!/bin/bash

echo "Execute custom patch.sh"

# add custom packages
svn co https://github.com/Lienol/openwrt-package/trunk/lienol/luci-app-ramfree package/luci-app-ramfree
