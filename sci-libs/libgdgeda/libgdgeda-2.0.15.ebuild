# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgdgeda/libgdgeda-2.0.15.ebuild,v 1.6 2006/09/05 18:27:26 gustavoz Exp $

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="libgdgeda - a PNG creation library for gEDA"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc sparc ~x86"
SLOT="0"

DEPEND=">=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	|| ( (	x11-libs/libXt
		x11-libs/libXpm
	     )
	     virtual/x11
	)"

src_compile() {

	econf || die
	emake || die

}

src_install () {

	einstall || die
	dodoc COPYING README.1ST

}
