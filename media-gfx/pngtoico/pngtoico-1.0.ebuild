# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngtoico/pngtoico-1.0.ebuild,v 1.2 2003/02/13 12:37:04 vapier Exp $

DESCRIPTION="Convert png images to MS ico format"
HOMEPAGE="http://www.kernel.org/pub/software/graphics/pngtoico/"
SRC_URI="ftp://ftp.kernel.org/pub/software/graphics/pngtoico/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-libs/libpng"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 Makefile < ${FILESDIR}/${P}-Makefile.patch
}

src_compile() {
	emake || die
}

src_install() {
	dobin pngtoico
	doman pngtoico.1
}
