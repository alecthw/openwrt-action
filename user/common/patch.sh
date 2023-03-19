#!/bin/bash

# Execute before update feeds
# patch -> [update & install feeds] -> custom -> config

target=$1
echo "Execute common patch.sh ${target}"

array=(${target//-/ })
source=${array[0]}
echo "Source: ${source}"

do_common() {
    # add custom packages
    git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
    git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
}

do_lienol_common() {
    # add custom packages
    git clone https://github.com/jerrykuku/luci-theme-argon.git -b 18.06 package/luci-theme-argon-jerrykuku
    svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-ramfree package/luci-app-ramfree

    # n2n_v2
    svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-n2n package/luci-app-n2n
    svn co https://github.com/coolsnowwolf/packages/trunk/net/n2n package/n2n
}

do_lede_common() {
    # add custom packages
    git clone https://github.com/jerrykuku/luci-theme-argon.git -b 18.06 package/luci-theme-argon-jerrykuku
    svn co https://github.com/Lienol/openwrt-package/branches/other/luci-app-tcpdump package/luci-app-tcpdump
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
