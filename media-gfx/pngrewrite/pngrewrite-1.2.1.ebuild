# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngrewrite/pngrewrite-1.2.1.ebuild,v 1.2 2004/03/18 14:06:06 ciaranm Exp $

DESCRIPTION="A utility which reduces large palettes in PNG images"
HOMEPAGE="http://entropymine.com/jason/pngrewrite/"
SRC_URI="http://entropymine.com/jason/pngrewrite/${P}.zip"

DEPEND="media-libs/libpng
	sys-libs/zlib"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~x86 ~sparc"

IUSE=""

S="${WORKDIR}"

src_compile () {
	gcc -o pngrewrite pngrewrite.c -lpng -lz $CFLAGS || die
}

src_install () {
	dobin pngrewrite
}

