#!/bin/bash
# Minimal firewall with IPTABLES.

set -e
set -u

# Flush rules.
iptables -F

# Make it a stateful firewall.
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Free the loopback.
iptables -I INPUT 1 -i lo -j ACCEPT

# Drop packets with invalid headers or checksums, invalid TCP flags, invalid
# ICMP messages, out of sequence packets, etc.
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

# Allow ICMP echo requests (pings).
iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT

# Politely, reject incoming network connections and datagrams by default.
iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp -j REJECT --reject-with tcp-reset

iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable

# Allow services.
iptables -I INPUT -p tcp --dport 22 -j ACCEPT

