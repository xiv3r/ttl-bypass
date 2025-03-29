# ttl-bypass
Simple nftables config that can bypass any wifi anti-tethering & anti-hotspot sharing using openwrt router.

<div align="center">
<img width="50%" height="50%" src="https://github.com/xiv3r/ttl-bypass/blob/main/ttl.png">
</div>

# Support
- Works both WAN and WLAN (extender/repeater/wireless bridge)
- Support Ipv4 & Ipv6
- Force all the ttl value of 1 arrived in any interface are set to 64

# Requirement
- Openwrt Router configured as (`extender/repeater/wireless bridge mode`) must be connected to a wifi with TTL value of 1

# Check the WIFI access point ttl value

```
ping 10.0.0.1
```

# Access Openwrt router ssh or telnet
- ssh: `ssh root@192.168.1.1`
- telnet: `telnet 192.168.1.1`

# Install Permanently
```
wget -O /etc/nftables.d/ttl64.nft https://raw.githubusercontent.com/xiv3r/ttl-bypass/refs/heads/main/ttl64.nft && fw4 check && /etc/init.d/firewall restart
```
# Result 
- Path: `cat /etc/nftables.d/ttl64.nft`

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
```
wget -qO- https://raw.githubusercontent.com/xiv3r/ttl-bypass/refs/heads/main/ttl64.sh | sh
```
# Openwrt ssh CLI
```sh
nft 'add table inet mangle'

nft 'add chain inet mangle mangle_prerouting_ttl64 { type filter hook prerouting priority 300; policy accept; }'

nft 'add rule inet mangle mangle_prerouting_ttl64 ip ttl set 64'

nft 'add rule inet mangle mangle_prerouting_ttl64 ip6 hoplimit set 64'

nft 'add chain inet mangle mangle_postrouting_ttl64 { type filter hook postrouting priority 300; policy accept; }'

nft 'add rule inet mangle mangle_postrouting_ttl64 ip ttl set 64'

nft 'add rule inet mangle mangle_postrouting_ttl64 ip6 hoplimit set 64'
```
</details>
