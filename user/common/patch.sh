#!/bin/bash

# Execute before update feeds

target=$1
echo "Execute common patch.sh ${target}"

array=(${target//-/ })
source=${array[0]}
echo "Source: ${source}"

do_common() {
    # add custom packages
    git clone https://github.com/jerrykuku/luci-theme-argon.git -b 18.06 package/luci-theme-argon-jerrykuku
    svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-control-webrestriction package/luci-app-control-webrestriction
}

do_lienol_common() {
    # add custom packages
    svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-ramfree package/luci-app-ramfree
}

do_lede_common() {
    # add custom packages
    svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-tcpdump package/luci-app-tcpdump

    # remove n2n
    rm -rf package/lean/luci-app-n2n_v2
    rm -rf package/lean/n2n_v2
}

# excute begin
do_common

case "${source}" in
lienol)
    echo "do lienol"
    do_lienol_common
    ;;
lede)
    echo "do lede"
    do_lede_common
    ;;
*)
    echo "Unknow ${source}!"
    ;;
esac
