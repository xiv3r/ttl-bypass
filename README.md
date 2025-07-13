# TTL Bypass for openwrt wireless extender 

Simple nftables ttl config that can bypass any wifi anti-tethering and anti-hotspot sharing using openwrt router.

<br>

<div align="center">
SOURCE: 10.0.0.1/20 ttl=1

  👇

Openwrt extender with nftables ttl generator
(ip ttl set 64)

👇

DESTINATION: 10.0.0.1/20 ttl=64

<img src="https://github.com/xiv3r/ttl-bypass/blob/main/fw4-firewall.png">
<img src="https://github.com/xiv3r/ttl-bypass/blob/main/ttl.png">
  
</div>

# Requirements
- Openwrt Router => configured as (`extender/repeater/wireless bridge mode`) must be connected to a wifi with TTL value of 1

# SSH or Telnet
- SSH: `ssh root@192.168.1.1`
- Telnet: `telnet 192.168.1.1`

# Install
> persistent
```
wget -O /etc/nftables.d/ttl64.nft https://raw.githubusercontent.com/xiv3r/ttl-bypass/refs/heads/main/ttl64.nft && fw4 check && /etc/init.d/firewall restart
```
# config
> Path: `vim /etc/nftables.d/ttl64.nft`

```sh
chain mangle_prerouting_ttl64 {
                type filter hook prerouting priority 300; policy accept;
                ip ttl set 64
                ip6 hoplimit set 64
        }

chain mangle_postrouting_ttl64 {
                type filter hook postrouting priority 300; policy accept;
                ip ttl set 64
                ip6 hoplimit set 64
        }
```

<details><summary></summary>
  
# Run in ssh CLI
> optional
```
wget -qO- https://raw.githubusercontent.com/xiv3r/ttl-bypass/refs/heads/main/ttl64.sh | sh
```
# Openwrt ssh CLI
```
nft 'add table inet mangle'
```
```
nft 'add chain inet mangle mangle_prerouting_ttl64 { type filter hook prerouting priority 300; policy accept; }'
```
```
nft 'add rule inet mangle mangle_prerouting_ttl64 ip ttl set 64'
```
```
nft 'add rule inet mangle mangle_prerouting_ttl64 ip6 hoplimit set 64'
```
```
nft 'add chain inet mangle mangle_postrouting_ttl64 { type filter hook postrouting priority 300; policy accept; }'
```
```
nft 'add rule inet mangle mangle_postrouting_ttl64 ip ttl set 64'
```
```
nft 'add rule inet mangle mangle_postrouting_ttl64 ip6 hoplimit set 64'
```
</details>
