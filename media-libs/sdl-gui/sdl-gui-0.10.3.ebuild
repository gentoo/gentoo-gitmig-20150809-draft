# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-gui/sdl-gui-0.10.3.ebuild,v 1.1 2003/06/28 07:01:28 vapier Exp $

MY_P=SDL_gui-${PV}
DESCRIPTION="Graphical User Interface library that utilizes SDL"
HOMEPAGE="http://www.newimage.com/~rhk/SDL_gui"
SRC_URI="http://www.newimage.com/~rhk/SDL_gui/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=media-libs/libsdl-1.1.4
	>=media-libs/sdl-image-1.0.9
	>=media-libs/sdl-ttf-1.2.1"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README TODO
}
