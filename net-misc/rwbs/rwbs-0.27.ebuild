# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

DESCRIPTION="Roger Wilco base station"
HOMEPAGE="http://rogerwilco.gamespy.com/"
SRC_URI="http://games.gci.net/pub/VoiceOverIP/RogerWilco/rwbs_Linux_0_27.tar.gz"

KEYWORDS="~x86"
SLOT="0"

# Everything is statically linked
DEPEND=""

S=${WORKDIR}

src_install() {
	dodoc README.TXT CHANGES.TXT LICENSE.TXT

	dobin ${S}/rwbs ${S}/run_rwbs
	rm -f ${S}/rwbs ${S}/run_rwbs

	# Put distribution into /usr/share/rwbs
	dodir /usr/share/rwbs/
	mv * ${D}/usr/share/rwbs/

	# Do conf script
	dodir /etc/conf.d/
	cat > ${D}/etc/conf.d/rwbs <<EOF
# Roger Wilco base station configuration
#
# $ rwbs --help reads:
# usage: ./rwbs [-b(ackwardcompat)] [-t(est)] [-s(tatic)] [-p <passwd>] [-u <udpport>] [-x <connectspeed>] [-n <hostname>]
#    connectspeed is an integer measuring the allocated broadcast
#     capacity for the channel host.  The recommended value is 1.
#     Higher values will cause the RWBS to use its additional broadcast capacity
#     to help relay transmissions, at the expense of scalability.
#   the b(ackwardcompat) option tells RWBS to appear as a "user" on the
#     channel.  Mark I users will prefer this, but not Mark Ia users.
#   The s(tatic) option indicates that a client asking to join a
#     non-existent named channel should be turned away with an error.
#     rather than being hosted on a dynamically-created channel.
#   hostname is what your station's name will be in the Roger Wilco Channel Tab.
#     For instance, if you used -n "Clan Hurt", Roger Wilco users will see
#     an entry in the Channel window named "Clan Hurt Base"
#   If the -t(est) flag is used, the base station echoes transmissions
#     when there is just one other party on the channel.

# Specify whatever options you want on this line
RWBS_OPTS='-n "Gentoo Linux"'
EOF

	# do init script
	dodir /etc/init.d/
	cat > ${D}/etc/init.d/rwbs <<EOF
#!/sbin/runscript
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

depend() {
        need net
}

start() {
        ebegin "Starting Roger Wilco base station"
        start-stop-daemon --start --quiet --exec /usr/bin/rwbs -b \\
                -- \${RWBS_OPTS} >>/var/log/rwbs 2>&1
        eend $?
}

stop() {
        ebegin "Stopping Roger Wilco base station"
        start-stop-daemon --stop --quiet --exec /usr/bin/rwbs \\
                > /dev/null 2>&1
        eend $?
}
EOF
	chmod 755 ${D}/etc/init.d/rwbs
}

pkg_postinst() {
	einfo
	einfo "This build of ${PN} uses an init script, located at"
	einfo "/etc/init.d/rwbs, to start and stop ${PN}."
	einfo
}
