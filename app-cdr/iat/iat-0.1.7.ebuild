# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/iat/iat-0.1.7.ebuild,v 1.1 2009/10/07 09:02:17 scarabeus Exp $

EAPI="2"

DESCRIPTION="BIN, MDF, PDI, CDI, NRG, and B5I converters"
HOMEPAGE="http://iat.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_configure() {
	econf --disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README || die "dodoc failed"
}
