# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdv/libdv-0.9.5-r1.ebuild,v 1.4 2002/07/22 14:56:59 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="software codec for dv-format video (camcorders etc)"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	ftp://download.sourceforge.net/pub/sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://libdv.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	dev-util/pkgconfig
	sdl? ( >=media-libs/libsdl-1.2.4.20020601 )"

src_compile() {

	use sdl \
		&& myconf="$myconf --enable-sdl" \
		|| myconf="$myconf --disable-sdl"

	unset CFLAGS CXXFLAGS

	econf ${myconf} || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
}

