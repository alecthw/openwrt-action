#!/bin/bash

# Execute before update feeds
# patch -> [update & install feeds] -> custom -> config

target=$1
echo "Execute common patch.sh ${target}"

target_array=(${target//-/ })
build_source=${target_array[0]}
build_type=${target_array[1]}
build_arch=${target_array[2]}
echo "source=${build_source}, type=${build_type}, arch=${build_arch}"

do_common() {
    echo ""
}

do_official_common() {
    # add custom packages
    rm -rf package/luci-theme-argon-jerrykuku
    git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-jerrykuku
}

do_lede_common() {
    # add custom packages
    rm -rf package/luci-theme-argon-jerrykuku
    git clone https://github.com/jerrykuku/luci-theme-argon.git -b 18.06 package/luci-theme-argon-jerrykuku

    rm -rf package/luci-app-tcpdump
    svn co https://github.com/Lienol/openwrt-package/branches/other/luci-app-tcpdump package/luci-app-tcpdump
}

# excute begin
do_common

case "${build_source}" in
official)
    echo "do official"
    do_official_common
    ;;
lede)
    echo "do lede"
    do_lede_common
    ;;
*)
    echo "Unknow ${build_source}!"
    ;;
esac
