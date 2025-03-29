#!/bin/bash

nft add chain inet mangle mangle_prerouting_ttl64 '{ type filter hook prerouting priority 300; policy accept; }'
nft add rule inet mangle mangle_prerouting_ttl64 ip ttl set 64
nft add rule inet mangle mangle_prerouting_ttl64 ip6 hoplimit set 64
