# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/heartbeat/heartbeat-1.0.4.ebuild,v 1.4 2004/01/23 06:11:04 iggy Exp $

DESCRIPTION="Heartbeat high availability cluster manager"
HOMEPAGE="http://www.linux-ha.org"
SRC_URI="http://www.linux-ha.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -mips"
IUSE="ldirectord"

DEPEND="dev-libs/popt
	dev-libs/glib
	net-libs/libnet
	ldirectord? (	sys-cluster/ipvsadm
			dev-perl/libwww-perl
			dev-perl/perl-ldap
			dev-perl/libnet )"

# need to add dev-perl/Mail-IMAPClient inside ldirectord above

src_compile() {
	./configure --prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--with-group-name=cluster \
		--with-group-id=65 \
		--with-ccmuser-name=cluster \
		--with-ccmuser-id=65 || die
	emake || die
}

pkg_preinst() {
	# check for cluster group, if it doesn't exist make it
	if ! grep -q cluster.*65 /etc/group ; then
		groupadd -g 65 cluster
	fi
	# check for cluster user, if it doesn't exist make it
	if ! grep -q cluster.*65 /etc/passwd ; then
		useradd -u 65 -g cluster -s /dev/null -d /var/lib/heartbeat cluster
	fi
}

src_install() {
	make DESTDIR=${D} install || die

	# if ! USE="ldirectord" then don't install it
	if [ ! `use ldirectord` ] ; then
		rm ${D}/etc/init.d/ldirectord
		rm ${D}/etc/logrotate.d/ldirectord
		rm ${D}/usr/man/man8/supervise-ldirectord-config.8
		rm ${D}/usr/man/man8/ldirectord.8
		rm ${D}/usr/sbin/ldirectord
		rm ${D}/usr/sbin/supervise-ldirectord-config
	fi

	exeinto /etc/init.d
	newexe ${FILESDIR}/heartbeat-init heartbeat
}
