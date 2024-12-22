# ttl-bypass
Simple nftables config that can bypass any pisowifi anti-tethering & anti-hotspot sharing using openwrt router.

# Req
- Openwrt Router (`extender/repeater mode`)

# Access ssh or telnet
- ssh: `ssh root@192.168.1.1`
- telnet: `telnet 192.168.1.1`

# Install
```
wget -O /etc/nftables.d/ttl64.nft https://raw.githubusercontent.com/xiv3r/ttl-bypass/refs/heads/main/ttl64.nft
```

# Config
- Path: `/etc/nftables.d/ttl64.nft`

```sh
chain mangle_prerouting_ttl64 {
  type filter hook prerouting priority 300; policy accept;
   counter ip ttl set 64
   counter ip6 hoplimit set 64
}
```

# CLI
```sh
# Create the chain
nft add chain ip mangle mangle_prerouting_ttl64 { type filter hook prerouting priority 300; policy accept; }

# Add rules to the chain
nft add rule ip mangle mangle_prerouting_ttl64 counter ip ttl set 64
nft add rule ip mangle mangle_prerouting_ttl64 counter ip6 hoplimit set 64
```
