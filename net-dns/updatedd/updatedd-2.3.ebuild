# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/updatedd/updatedd-2.3.ebuild,v 1.1 2005/01/08 00:46:21 dragonheart Exp $

inherit eutils

DESCRIPTION="Dynamic DNS client with plugins for several dynamic dns services"
HOMEPAGE="http://updatedd.philipp-benner.de/"
SRC_URI="http://savannah.nongnu.org/download/updatedd/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	# Fix the Makefile.in so $(bindir) is created before installing files there
	cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch || die "Patch Failed"
}

src_install() {
	emake DESTDIR=${D} install || die
	mv ${D}/usr/share/doc/updatedd ${D}/usr/share/doc/${PF}
	dodoc AUTHORS
}
