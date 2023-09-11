#!/bin/bash

# Execute after install feeds as the last script
# patch -> [update & install feeds] -> custom -> config

target=$1
echo "Execute common config.sh ${target}"

target_array=(${target//-/ })
build_source=${target_array[0]}
build_type=${target_array[1]}
build_arch=${target_array[2]}
echo "source=${build_source}, type=${build_type}, arch=${build_arch}"

# copy default config
if [ -d "../defconfig" ]; then
    cp -f ../defconfig/etc/uci-defaults/zzzz-extra-settings package/base-files/files/etc/uci-defaults/zzzz-extra-settings

    if [ "${build_type}" != "openclash" ]; then
        cp -f ../defconfig/etc/firewall.user package/network/config/firewall/files/firewall.user
    else
        # special for openclash
        cp -f ../defconfig/etc/firewall_openclash.user package/network/config/firewall/files/firewall.user
    fi

    if [ -d "package/feeds/packages/nginx-util" ]; then
        cp -f ../defconfig/etc/config/nginx package/feeds/packages/nginx-util/files/nginx.config
    fi

    if [ -d "package/feeds/luci/luci-app-adbyby-plus" ]; then
        cp -f ../defconfig/etc/config/adbyby package/feeds/luci/luci-app-adbyby-plus/root/etc/config/adbyby
    fi
    if [ -d "package/feeds/other/luci-app-adbyby-plus" ]; then
        cp -f ../defconfig/etc/config/adbyby package/feeds/other/luci-app-adbyby-plus/root/etc/config/adbyby
    fi

    if [ -d "package/feeds/passwall/luci-app-passwall" ]; then
        cp -f ../defconfig/etc/config/passwall package/feeds/passwall/luci-app-passwall/root/etc/config/passwall
        cp -rf ../defconfig/usr/share/passwall/* package/feeds/passwall/luci-app-passwall/root/usr/share/passwall/
        chmod 775 package/feeds/passwall/luci-app-passwall/root/usr/share/passwall/curl_ping.sh
        chmod 775 package/feeds/passwall/luci-app-passwall/root/usr/share/passwall/test_node.sh

        mkdir package/feeds/passwall/luci-app-passwall/root/usr/share/geodata
        curl -kL --retry 3 --connect-timeout 3 -o package/feeds/passwall/luci-app-passwall/root/usr/share/geodata/geoip.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
        curl -kL --retry 3 --connect-timeout 3 -o package/feeds/passwall/luci-app-passwall/root/usr/share/geodata/geosite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
    fi

    if [ -d "package/feeds/luci/luci-app-smartdns" ]; then
        mkdir -p package/feeds/luci/luci-app-smartdns/root/etc/config
        mkdir -p package/feeds/luci/luci-app-smartdns/root/etc/smartdns
        if [ "${build_type}" != "openclash" ]; then
            cp -f ../defconfig/etc/config/smartdns package/feeds/luci/luci-app-smartdns/root/etc/config/smartdns
            cp -rf ../defconfig/etc/smartdns/custom.conf package/feeds/luci/luci-app-smartdns/root/etc/smartdns/custom.conf
        else
            # special for openclash
            cp -f ../defconfig/etc/config/smartdns_openclash package/feeds/luci/luci-app-smartdns/root/etc/config/smartdns
            cp -rf ../defconfig/etc/smartdns/custom_openclash.conf package/feeds/luci/luci-app-smartdns/root/etc/smartdns/custom.conf
        fi
        cp -rf ../defconfig/etc/smartdns/anti-ad.sh package/feeds/luci/luci-app-smartdns/root/etc/smartdns/anti-ad.sh
        if [ -f "package/feeds/luci/luci-app-smartdns/root/etc/smartdns/anti-ad.sh" ]; then
            curl -kL --retry 3 --connect-timeout 3 -o package/feeds/luci/luci-app-smartdns/root/etc/smartdns/anti-ad-smartdns.conf https://anti-ad.net/anti-ad-for-smartdns.conf
            chmod 755 package/feeds/luci/luci-app-smartdns/root/etc/smartdns/anti-ad.sh
        fi
    fi

    if [ -d "package/feeds/luci/luci-app-mosdns" ]; then
        cp -f ../defconfig/etc/config/mosdns package/feeds/luci/luci-app-mosdns/root/etc/config/mosdns

        # copy config
        cp -f ../defconfig/etc/mosdns/config_custom.yaml package/feeds/luci/luci-app-mosdns/root/etc/mosdns/config_custom.yaml
        cp -f ../defconfig/etc/mosdns/update_rules.sh package/feeds/luci/luci-app-mosdns/root/etc/mosdns/update_rules.sh
        chmod 755 package/feeds/luci/luci-app-mosdns/root/etc/mosdns/update_rules.sh

        # download rules
        curl -kL --retry 3 --connect-timeout 3 -o package/feeds/luci/luci-app-mosdns/root/etc/mosdns/rule/reject-list.txt https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/reject-list.txt
        curl -kL --retry 3 --connect-timeout 3 -o package/feeds/luci/luci-app-mosdns/root/etc/mosdns/rule/cn-white.txt https://raw.githubusercontent.com/alecthw/chnlist/release/mosdns/whitelist.list
        curl -kL --retry 3 --connect-timeout 3 -o package/feeds/luci/luci-app-mosdns/root/etc/mosdns/rule/Country.mmdb https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb
    fi
    if [ -d "package/luci-app-mosdns" ]; then
        cp -f ../defconfig/etc/config/mosdns package/luci-app-mosdns/root/etc/config/mosdns

        # copy config
        cp -f ../defconfig/etc/mosdns/config_custom.yaml package/luci-app-mosdns/root/etc/mosdns/config_custom.yaml
        cp -f ../defconfig/etc/mosdns/update_rules.sh package/luci-app-mosdns/root/etc/mosdns/update_rules.sh
        chmod 755 package/luci-app-mosdns/root/etc/mosdns/update_rules.sh

        # download rules
        curl -kL --retry 3 --connect-timeout 3 -o package/luci-app-mosdns/root/etc/mosdns/rule/reject-list.txt https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/reject-list.txt
        curl -kL --retry 3 --connect-timeout 3 -o package/luci-app-mosdns/root/etc/mosdns/rule/cn-white.txt https://raw.githubusercontent.com/alecthw/chnlist/release/mosdns/whitelist.list
        curl -kL --retry 3 --connect-timeout 3 -o package/luci-app-mosdns/root/etc/mosdns/rule/Country.mmdb https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb
    fi

    # --------------- mini
    cp -f ../defconfig/etc/hosts package/base-files/files/etc/hosts

    if [ -d "package/luci-app-adguardhome" ]; then
        cp -f ../defconfig/etc/config/AdGuardHome package/luci-app-adguardhome/root/etc/config/AdGuardHome
        cp -rf ../defconfig/etc/AdGuardHome package/luci-app-adguardhome/root/etc/AdGuardHome

        # download latest adguardhome core
        curl -kL --retry 3 --connect-timeout 3 -o package/luci-app-adguardhome/root/etc/AdGuardHome.tar.gz https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_amd64.tar.gz
        tar xzf package/luci-app-adguardhome/root/etc/AdGuardHome.tar.gz -C package/luci-app-adguardhome/root/etc/
        rm -rf package/luci-app-adguardhome/root/etc/AdGuardHome.tar.gz
    fi

    if [ -d "package/luci-app-openclash" ]; then
        cp -f ../defconfig/etc/config/openclash package/luci-app-openclash/root/etc/config/openclash
        # sed -i '/^config dns_servers/,$d' package/luci-app-openclash/root/etc/config/openclash

        mkdir -p package/luci-app-openclash/root/etc/openclash/config
        cp -f ../defconfig/etc/openclash/config/OpenClash.yaml package/luci-app-openclash/root/etc/openclash/config/OpenClash.yaml

        # update geosite
        rm -rf package/luci-app-openclash/root/etc/openclash/GeoSite.dat
        curl -kL --retry 3 --connect-timeout 3 -o package/luci-app-openclash/root/etc/openclash/GeoSite.dat https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geosite.dat

        # update mmdb
        rm -rf package/luci-app-openclash/root/etc/openclash/Country.mmdb
        curl -kL --retry 3 --connect-timeout 3 -o package/luci-app-openclash/root/etc/openclash/Country.mmdb https://testingcf.jsdelivr.net/gh/alecthw/mmdb_china_ip_list@release/Country.mmdb

        # download rule provider files
        rm -rf package/luci-app-openclash/.svn
        rm -rf package/luci-app-openclash/root/etc/openclash/rule_provider
        svn co -q https://github.com/blackmatrix7/ios_rule_script/trunk/rule/Clash package/luci-app-openclash/root/etc/openclash/rule_provider/rules
        rm -rf package/luci-app-openclash/root/etc/openclash/rule_provider/rules/.svn
        mv -f package/luci-app-openclash/root/etc/openclash/rule_provider/rules/**/*.yaml package/luci-app-openclash/root/etc/openclash/rule_provider
        rm -rf package/luci-app-openclash/root/etc/openclash/rule_provider/rules

        svn co -q https://github.com/alecthw/chnlist/branches/release/Providers/Custom package/luci-app-openclash/root/etc/openclash/rule_provider
        rm -rf package/luci-app-openclash/root/etc/openclash/rule_provider/.svn
    fi

    if [ -d "package/feeds/luci/luci-app-turboacc" ]; then
        cp -f ../defconfig/etc/config/turboacc package/feeds/luci/luci-app-turboacc/root/etc/config/turboacc
    fi
    if [ -d "package/feeds/other/luci-app-turboacc" ]; then
        cp -f ../defconfig/etc/config/turboacc package/feeds/other/luci-app-turboacc/root/etc/config/turboacc
    fi

    if [ -d "package/feeds/packages/n2n" ]; then
        cp -f ../defconfig/etc/config/n2n package/feeds/packages/n2n/files/n2n.config
    fi
    if [ -d "package/n2n" ]; then
        cp -f ../defconfig/etc/config/n2n package/n2n/files/n2n.config
    fi

    if [ -d "package/feeds/packages/udpxy" ]; then
        cp -f ../defconfig/etc/config/udpxy package/feeds/packages/udpxy/files/udpxy.conf
    fi

    if [ -d "package/feeds/luci/luci-app-vlmcsd" ]; then
        cp -f ../defconfig/etc/config/vlmcsd package/feeds/luci/luci-app-vlmcsd/root/etc/config/vlmcsd
    fi
    if [ -d "package/feeds/other/luci-app-vlmcsd" ]; then
        cp -f ../defconfig/etc/config/vlmcsd package/feeds/other/luci-app-vlmcsd/root/etc/config/vlmcsd
    fi

    if [ -d "feeds/packages/net/zerotier" ]; then
        cp -f ../defconfig/etc/config/zerotier feeds/packages/net/zerotier/files/etc/config/zerotier
        tar xzf ../defconfig/etc/config/zero.tar.gz -C feeds/packages/net/zerotier/files/etc/config/
    fi
    # --------------- mini
fi
