# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libotf/libotf-0.9-r1.ebuild,v 1.3 2004/07/19 02:17:57 tgall Exp $

DESCRIPTION="Library for handling OpenType fonts (OTF)"
HOMEPAGE="http://www.m17n.org/libotf/"
SRC_URI="http://www.m17n.org/libotf/${P}.tar.gz"

LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~amd64 ppc64"
IUSE="X"

DEPEND="X? ( virtual/x11 )
	>=media-libs/freetype-2.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	use X || sed -i -e '/^bin_PROGRAMS/s/otfview//' example/Makefile.in || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL NEWS README ChangeLog
}
