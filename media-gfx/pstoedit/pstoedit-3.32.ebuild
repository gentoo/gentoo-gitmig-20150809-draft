# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pstoedit/pstoedit-3.32.ebuild,v 1.10 2004/02/02 21:07:56 mholzer Exp $

inherit libtool

IUSE="flash"

S=${WORKDIR}/${P}
DESCRIPTION="translates PostScript and PDF graphics into other vector formats"
SRC_URI="http://home.t-online.de/home/helga.glunz/wglunz/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.pstoedit.net/pstoedit"

SLOT="0"
LICENSE="GPL-2"
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
	econf
	make || die
}

src_install () {

	make DESTDIR=${D} install || die "make install failed"
	dodoc readme.txt copying
	dohtml changelog.htm index.html doc/pstoedit.htm
	doman doc/pstoedit.1

}
