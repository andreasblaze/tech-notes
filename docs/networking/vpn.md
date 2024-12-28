# VPN
Some info...

## IPSec

## MTU
**MTU** (*The maximum transmission unit*) is the size, in bytes, of the largest packet supported by a network layer protocol, including both headers and IP packet payload. Network packets sent over a VPN tunnel are encrypted and then encapsulated in an outer packet so that they can be routed - [MTU considerations | Cloud VPN](https://cloud.google.com/network-connectivity/docs/vpn/concepts/mtu-considerations)
> Можно затраблшутить сетевые проблемы между локациями VPN увеличив **MTU**, например с `1400` до `1414`.