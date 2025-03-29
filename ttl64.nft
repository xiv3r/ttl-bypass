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
