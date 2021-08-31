# OpenWRT Actions

Build OpenWRT using github actions!

![Badge](https://github.com/alecthw/openwrt-action/workflows/Openwrt-AutoBuild/badge.svg)

Lienol's [code](https://github.com/Lienol/openwrt)

Lean's [code](https://github.com/coolsnowwolf/lede)

Default IP: `192.168.11.1/24`, no password.

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
- libustream-wolfssl disable
- default-settings
- luci
- luci-ssl-openssl
- luci-compat
- luci-app-adbyby-plus
- luci-app-control-webrestriction
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
