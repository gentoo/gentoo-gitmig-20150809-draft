# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gd/gd-2.0.32.ebuild,v 1.2 2004/11/05 11:35:02 hardave Exp $

inherit gnuconfig eutils

DESCRIPTION="A graphics library for fast image creation"
HOMEPAGE="http://www.boutell.com/gd/"
SRC_URI="http://www.boutell.com/gd/http/${P}.tar.gz"

LICENSE="|| ( as-is BSD )"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE="jpeg png X truetype"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	png? ( >=media-libs/libpng-1.2.5 sys-libs/zlib )
	truetype? ( >=media-libs/freetype-2.1.5 )
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_compile() {
	econf \
		$(use_with png) \
		$(use_with truetype freetype) \
		$(use_with jpeg) \
		$(use_with X xpm) \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc INSTALL README*
	dohtml -r ./
}
