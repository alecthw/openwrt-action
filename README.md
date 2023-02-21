# OpenWRT Actions

This is a private firmware. Firmware is encrypted!

Please do not download artifact!

Build OpenWRT using github actions!

[![ysh](https://github.com/alecthw/openwrt-action/actions/workflows/ysh.yml/badge.svg)](https://github.com/alecthw/openwrt-action/actions/workflows/ysh.yml)
[![sxyg](https://github.com/alecthw/openwrt-action/actions/workflows/sxyg.yml/badge.svg)](https://github.com/alecthw/openwrt-action/actions/workflows/sxyg.yml)

Lean's [code](https://github.com/coolsnowwolf/lede)

Lienol's [code](https://github.com/Lienol/openwrt)

Default IP: `192.168.11.1/24`.

## Img Config

- Disable ext4 img
- GZip images
- VMWare images

## Apps and packages

- KERNEL_PARTSIZE 32
- ROOTFS_PARTSIZE 760
- dnsmasq-full
- ipv6helper
- kmod-vmxnet3
- default-settings
- luci
- luci-ssl
- luci-compat
- luci-app-adbyby-plus
- luci-app-n2n_n2
- luci-app-passwall
- luci-app-smartdns
- luci-app-ssr-plus
- luci-app-tcpdump
- luci-app-turboacc
- luci-app-udpxy
- luci-app-vlmcsd
- luci-theme-argon-jerrykuku
- luci-theme-material
- luci-proto-bonding
- luci-lib-ipkg
- wget
- openssl-sftp-server
- snmpd
- open-vm-tools
