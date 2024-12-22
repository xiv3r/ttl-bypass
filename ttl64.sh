#!/bin/sh -e

# Create the chain
nft add chain ip mangle mangle_prerouting_ttl64 { type filter hook prerouting priority 300; policy accept; }
#
# Add rules to the chain
nft add rule ip mangle mangle_prerouting_ttl64 counter ip ttl set 64
#
nft add rule ip mangle mangle_prerouting_ttl64 counter ip6 hoplimit set 64
