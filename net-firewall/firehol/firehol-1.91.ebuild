# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/firehol/firehol-1.91.ebuild,v 1.3 2004/04/21 16:17:47 vapier Exp $

DESCRIPTION="iptables firewall generator"
HOMEPAGE="http://firehol.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="net-firewall/iptables"

src_compile() {
	sed -i \
		-e 's|/etc/firehol.conf|/etc/firehol/firehol.conf|' \
		firehol.sh
}

src_install() {
	newsbin firehol.sh firehol || die
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
