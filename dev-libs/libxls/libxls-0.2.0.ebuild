# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxls/libxls-0.2.0.ebuild,v 1.3 2010/05/03 21:36:42 ssuominen Exp $

EAPI=2

DESCRIPTION="A library which can read Excel (xls) files"
HOMEPAGE="http://libxls.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/libintl
	!<app-text/catdoc-0.94.2-r2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS TODO
	dohtml doc/homepage/*.{css,html}
	find "${D}" -name '*.la' -delete
}
