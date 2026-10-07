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

# SSH or Telnet
- SSH: `ssh root@192.168.1.1`
- Telnet: `telnet 192.168.1.1`
> user:`root`
> 
> password:`(admin password)`

# Install
> First configure the Openwrt Router into (`extender/repeater/wireless bridge mode`) before connecting to the wifi access point with TTL=1
```
wget -O /etc/nftables.d/ttl-64.nft https://raw.githubusercontent.com/xiv3r/ttl-bypass/refs/heads/main/ttl64.nft && fw4 check && /etc/init.d/firewall restart
```
# Uninstall
```
rm -f /etc/nftables.d/ttl-64.nft && /etc/init.d/firewall restart
```
# Config
> Path: `vim /etc/nftables.d/ttl-64.nft`

```
chain mangle_prerouting_ttl64 {
                type filter hook prerouting priority 300; policy accept;
                ip ttl set 64
                ip6 hoplimit set 64
        }
```
> after set restart the firewall to apply
```
/etc/init.d/firewall restart
```

# To Check
> ping the gateway 10.0.0.1
```
ping 10.0.0.1
```

<details><summary>

# For Iptables (optional)
</summary>

> persistent
```
vi /etc/rc.local
```
> place before the `exit 0`
```
iptables -t mangle -A PREROUTING -j TTL --ttl-set 64
```
</details>

<details><summary></summary>
  
# For CLI (optional)
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

# Check the rulesets
```
nft list ruleset
```
</details>
