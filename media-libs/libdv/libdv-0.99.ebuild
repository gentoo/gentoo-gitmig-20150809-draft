# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdv/libdv-0.99.ebuild,v 1.4 2003/08/18 17:36:05 max Exp $

DESCRIPTION="Software codec for dv-format video (camcorders etc)."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://libdv.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha amd64"
IUSE="sdl xv"

DEPEND="dev-libs/popt
	dev-util/pkgconfig
	=x11-libs/gtk+-1.2*
	sdl? ( >=media-libs/libsdl-1.2.4.20020601 )
	xv? ( virtual/x11 )"
	
src_compile() {
	local myconf
	myconf="${myconf} `use_with debug`"
	myconf="${myconf} `use_enable sdl`"
	myconf="${myconf} `use_enable xv`"

	unset CFLAGS CXXFLAGS

	econf ${myconf}
	make || die "compile problem."
}

src_install () {
	einstall DESTDIR="${D}"
	dodoc AUTHORS COPYING COPYRIGHT ChangeLog INSTALL NEWS README* TODO
}
