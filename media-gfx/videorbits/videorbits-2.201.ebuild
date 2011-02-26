# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/videorbits/videorbits-2.201.ebuild,v 1.16 2011/02/26 18:29:10 signals Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="a collection of programs for creating high dynamic range images"
HOMEPAGE="http://comparametric.sourceforge.net/"
SRC_URI="mirror://sourceforge/comparametric/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/libX11
	sys-libs/zlib
	media-libs/libpng
	virtual/jpeg"

src_prepare() {
	cd "${S}"/images
	mv Makefile.in Makefile.in-orig
	sed -e "s:\$(prefix)/images:\$(prefix)/share/${PN}/images:" Makefile.in-orig > Makefile.in

	cd "${S}"/lookuptables
	mv Makefile.in Makefile.in-orig
	sed -e "s:\$(prefix)/lookuptables:\$(prefix)/share/${PN}/lookuptables:" Makefile.in-orig > Makefile.in
}

src_configure() {
	tc-export CC
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README README.MORE
}
