# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/firehol/firehol-1.159-r1.ebuild,v 1.5 2005/01/27 17:44:47 centic Exp $

DESCRIPTION="iptables firewall generator"
HOMEPAGE="http://firehol.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ~ppc"

RDEPEND="net-firewall/iptables
	sys-apps/iproute2"

src_compile() {
	sed -i firehol.sh \
		-e 's|/etc/firehol.conf|/etc/firehol/firehol.conf|' \
		-e 's|/sbin/ip|/usr/sbin/ip|' \
		-e 's|/usr/sbin/iptables|/sbin/iptables|' \
		-e 's|head -1|head -n 1|'
}

src_install() {
	newsbin firehol.sh firehol
	dodir /etc/firehol /etc/firehol/examples
	insinto /etc/firehol/examples
	doins examples/*
	dodoc ChangeLog COPYING README TODO WhatIsNew
	dohtml doc/*.html doc/*.css
	docinto scripts
	dodoc get-iana.sh adblock.sh
}

pkg_postinst() {
	einfo "The default path to firehol's configuration file is /etc/firehol/firehol.conf"
	einfo "See /etc/firehol/examples for configuration examples."
}
