# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pstoedit/pstoedit-3.32.ebuild,v 1.14 2005/02/21 14:50:54 usata Exp $

inherit libtool

DESCRIPTION="translates PostScript and PDF graphics into other vector formats"
SRC_URI="http://home.t-online.de/home/helga.glunz/wglunz/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.pstoedit.net/pstoedit"
LICENSE="GPL-2"

SLOT="0"
IUSE="flash"
KEYWORDS="x86 ppc"

DEPEND="media-libs/libpng
	media-libs/libexif
	sys-libs/zlib
	flash? ( media-libs/ming )"

RDEPEND="${DEPEND}
	virtual/ghostscript"

src_unpack() {

	unpack ${A}; cd ${S}
	# remove the -pedantic flag, see bug #39557
	sed -i -e "s/\-pedantic//" configure

}

src_compile() {
	elibtoolize
	econf || die "econf failed"
	make || die
}

src_install () {

	make DESTDIR=${D} install || die "make install failed"
	dodoc readme.txt copying
	dohtml changelog.htm index.html doc/pstoedit.htm
	doman doc/pstoedit.1

}
