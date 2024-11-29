#!/bin/sh
RC=${RC:=/etc/openvpn/server.conf}
die() { echo "DIE: $1"; exit 1; }
start_default() {
mkdir -p /etc/openvpn/ccd
echo "$CONFIG" > $RC
if [ -s "$RC" ]; then
	iptables -A POSTROUTING -t nat -s 10/8 -j MASQUERADE
	exec openvpn --config $RC
else
	echo "DIE: no config!"
	sleep 10
	exit 1
fi
}
case "$1" in
	"sh"|"bash")
		exec "$@";;
	"health")
		ip link show tap0 2>/dev/null | grep -q UP && ps a | tail -n +2 | grep -q openvpn;;
	"")
		start_default;;
	*)
		exec "$@";;
esac
