#!/bin/bash

# Execute after install feeds as the last script
# patch -> [update & install feeds] -> custom -> config

target=$1
echo "Execute common custom.sh ${target}"

# copy default config
if [ -d "../defconfig" ]; then
    cp -f ../defconfig/zzz-extra-settings package/base-files/files/etc/uci-defaults/zzzz-extra-settings

    if [ "${target}" != "lede-openclash-x64" ]; then
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
        if [ "${target}" != "lede-openclash-x64" ]; then
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
    if [ -d "package/luci-app-smartdns" ]; then
        mkdir -p package/luci-app-smartdns/root/etc/config
        mkdir -p package/luci-app-smartdns/root/etc/smartdns
        if [ "${target}" != "lede-openclash-x64" ]; then
            cp -f ../defconfig/etc/config/smartdns package/luci-app-smartdns/root/etc/config/smartdns
            cp -rf ../defconfig/etc/smartdns/custom.conf package/luci-app-smartdns/root/etc/smartdns/custom.conf
        else
            # special for openclash
            cp -f ../defconfig/etc/config/smartdns_openclash package/luci-app-smartdns/root/etc/config/smartdns
            cp -rf ../defconfig/etc/smartdns/custom_openclash.conf package/luci-app-smartdns/root/etc/smartdns/custom.conf
        fi
        cp -rf ../defconfig/etc/smartdns/anti-ad.sh package/luci-app-smartdns/root/etc/smartdns/anti-ad.sh
        if [ -f "package/luci-app-smartdns/root/etc/smartdns/anti-ad.sh" ]; then
            curl -kL --retry 3 --connect-timeout 3 -o package/luci-app-smartdns/root/etc/smartdns/anti-ad-smartdns.conf https://anti-ad.net/anti-ad-for-smartdns.conf
            chmod 755 package/luci-app-smartdns/root/etc/smartdns/anti-ad.sh
        fi
    fi

    # --------------- mini
    cp -f ../defconfig/etc/hosts package/base-files/files/etc/hosts

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
        svn co https://github.com/blackmatrix7/ios_rule_script/trunk/rule/Clash package/luci-app-openclash/root/etc/openclash/rule_provider/rules
        rm -rf package/luci-app-openclash/root/etc/openclash/rule_provider/rules/.svn
        mv -f package/luci-app-openclash/root/etc/openclash/rule_provider/rules/**/*.yaml package/luci-app-openclash/root/etc/openclash/rule_provider
        rm -rf package/luci-app-openclash/root/etc/openclash/rule_provider/rules

        svn co https://github.com/alecthw/chnlist/branches/release/Providers/Custom package/luci-app-openclash/root/etc/openclash/rule_provider
        rm -rf package/luci-app-openclash/root/etc/openclash/rule_provider/.svn
    fi

    if [ -d "package/feeds/luci/luci-app-mosdns" ]; then
        cp -f ../defconfig/etc/config/mosdns package/feeds/luci/luci-app-mosdns/root/etc/config/mosdns

        # copy config
        cp -f ../defconfig/etc/mosdns/cus_config.yaml package/feeds/luci/luci-app-mosdns/root/etc/mosdns/cus_config.yaml
        cp -f ../defconfig/etc/mosdns/update_rules.sh package/feeds/luci/luci-app-mosdns/root/etc/mosdns/update_rules.sh
        chomd 755 package/feeds/luci/luci-app-mosdns/root/etc/mosdns/update_rules.sh

        # download rules
        curl -kL --retry 3 --connect-timeout 3 -o package/feeds/luci/luci-app-mosdns/root/etc/mosdns/rule/reject-list.txt https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/reject-list.txt
        curl -kL --retry 3 --connect-timeout 3 -o package/feeds/luci/luci-app-mosdns/root/etc/mosdns/rule/cn-white.txt https://raw.githubusercontent.com/alecthw/chnlist/release/mosdns/whitelist.list
        curl -kL --retry 3 --connect-timeout 3 -o package/feeds/luci/luci-app-mosdns/root/etc/mosdns/rule/Country.mmdb https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb
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
