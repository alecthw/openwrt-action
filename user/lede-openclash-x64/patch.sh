#!/bin/bash

# Execute before update feeds

echo "Execute custom patch.sh"

# add custom packages
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash