# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/firehol/firehol-1.91.ebuild,v 1.2 2004/03/20 07:34:37 mr_bones_ Exp $

DESCRIPTION="iptables firewall generator"
HOMEPAGE="http://firehol.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="net-firewall/iptables"

src_compile() {
	mv firehol.sh firehol.sh.orig
	sed <firehol.sh.orig >firehol.sh \
		-e 's|/etc/firehol.conf|/etc/firehol/firehol.conf|'
}

src_install() {
	newsbin firehol.sh firehol
	dodir /etc/firehol /etc/firehol/examples
	insinto /etc/firehol/examples
	doins examples/*
	dodoc ChangeLog COPYING README TODO
	dohtml doc/*.html doc/*.css
	docinto scripts
	dodoc get-iana.sh doc/create_services.sh
}

pkg_postinst() {
	einfo "The default path to firehol's configuration file is /etc/firehol/firehol.conf"
	einfo "See /etc/firehol/examples for configuration examples."
}
