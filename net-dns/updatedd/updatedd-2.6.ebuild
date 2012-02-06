# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/updatedd/updatedd-2.6.ebuild,v 1.7 2012/02/06 15:36:42 ranger Exp $

inherit eutils

DESCRIPTION="Dynamic DNS client with plugins for several dynamic dns services"
HOMEPAGE="http://savannah.nongnu.org/projects/updatedd/"
SRC_URI="http://savannah.nongnu.org/download/updatedd/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~x86"
IUSE=""

RDEPEND=""

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-options.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
	mv "${D}"/usr/share/doc/updatedd "${D}"/usr/share/doc/${PF}
	dodoc AUTHORS
}
