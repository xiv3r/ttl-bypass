#!/bin/bash

nft 'add table inet mangle'
nft 'add chain inet mangle mangle_prerouting_ttl64 { type filter hook prerouting priority 300; policy accept; }'
nft 'add rule inet mangle mangle_prerouting_ttl64 ip ttl set 64'
nft 'add rule inet mangle mangle_prerouting_ttl64 ip6 hoplimit set 64'
nft 'add chain inet mangle mangle_postrouting_ttl64 { type filter hook postrouting priority 300; policy accept; }'
nft 'add rule inet mangle mangle_postrouting_ttl64 ip ttl set 64'
nft 'add rule inet mangle mangle_postrouting_ttl64 ip6 hoplimit set 64'
