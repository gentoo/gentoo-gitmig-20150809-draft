# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/videorbits/videorbits-2.201.ebuild,v 1.13 2009/10/24 12:39:42 nixnut Exp $

inherit toolchain-funcs

DESCRIPTION="a collection of programs for creating high dynamic range images"
HOMEPAGE="http://comparametric.sourceforge.net/"
SRC_URI="mirror://sourceforge/comparametric/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="
	x11-libs/libX11
	sys-libs/zlib
	media-libs/libpng
	media-libs/jpeg"

src_unpack() {
	unpack ${A}

	cd ${S}/images
	mv Makefile.in Makefile.in-orig
	sed -e "s:\$(prefix)/images:\$(prefix)/share/${PN}/images:" Makefile.in-orig > Makefile.in

	cd ${S}/lookuptables
	mv Makefile.in Makefile.in-orig
	sed -e "s:\$(prefix)/lookuptables:\$(prefix)/share/${PN}/lookuptables:" Makefile.in-orig > Makefile.in
}

src_compile() {
	tc-export CC
	econf || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING NEWS README README.MORE
}
