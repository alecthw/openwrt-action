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
    rm -rf package/luci-theme-argon-jerrykuku
    git clone https://github.com/jerrykuku/luci-theme-argon.git -b 18.06 package/luci-theme-argon-jerrykuku

    rm -rf package/luci-app-serverchan
    git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
}

do_official_common() {
    echo ""
}

do_lede_common() {
    # add custom packages
    rm -rf package/luci-app-tcpdump
    svn co https://github.com/Lienol/openwrt-package/branches/other/luci-app-tcpdump package/luci-app-tcpdump
}

# excute begin
do_common

case "${source}" in
official)
    echo "do official"
    do_official_common
    ;;
lede)
    echo "do lede"
    do_lede_common
    ;;
*)
    echo "Unknow ${source}!"
    ;;
esac
