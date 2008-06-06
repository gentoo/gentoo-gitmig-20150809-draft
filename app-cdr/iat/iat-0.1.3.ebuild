# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/iat/iat-0.1.3.ebuild,v 1.1 2008/06/06 21:48:29 drac Exp $

DESCRIPTION="BIN, MDF, PDI, CDI, NRG, and B5I converters"
HOMEPAGE="http://iat.berlios.de"
SRC_URI="mirror://berlios/iat/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}/${PN}

src_compile() {
	econf --disable-dependency-tracking
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS
}
