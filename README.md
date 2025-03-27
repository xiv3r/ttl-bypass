# ttl-bypass
Simple nftables config that can bypass any pisowifi anti-tethering & anti-hotspot sharing using openwrt router.

<div align="center">
<img width="50%" height="50%" src="https://github.com/xiv3r/ttl-bypass/blob/main/ttl.png">
</div>

# Support
- Works both WAN and WLAN (extender)
- Support Ipv4 & Ipv6

# Requirement
- Openwrt Router (`extender/repeater mode`) must be connected to a wifi with TTL value of 1

# Access ssh or telnet
- ssh: `ssh root@192.168.1.1`
- telnet: `telnet 192.168.1.1`

# Install Permanently
```
wget -O /etc/nftables.d/ttl64.nft https://raw.githubusercontent.com/xiv3r/ttl-bypass/refs/heads/main/ttl64.nft && fw4 check && /etc/init.d/firewall restart
```
# Openwrt Config
- Path: `/etc/nftables.d/ttl64.nft`

```sh
chain mangle_prerouting_ttl64 {
  type filter hook prerouting priority 300; policy accept;
   counter ip ttl set 64
   counter ip6 hoplimit set 64
}
```
<details><summary></summary>
  
# Run in ssh CLI
```
wget -qO- https://raw.githubusercontent.com/xiv3r/ttl-bypass/refs/heads/main/ttl64.sh | sh
```
# Openwrt ssh CLI
```sh
# Create the chain
nft add chain ip mangle mangle_prerouting_ttl64 { type filter hook prerouting priority 300; policy accept; }

# Add rules to the chain
nft add rule ip mangle mangle_prerouting_ttl64 counter ip ttl set 64
nft add rule ip mangle mangle_prerouting_ttl64 counter ip6 hoplimit set 64
```
</details>
