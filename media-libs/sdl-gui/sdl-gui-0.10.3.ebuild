# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-gui/sdl-gui-0.10.3.ebuild,v 1.2 2004/02/25 19:43:28 mr_bones_ Exp $

MY_P="SDL_gui-${PV}"
DESCRIPTION="Graphical User Interface library that utilizes SDL"
HOMEPAGE="http://www.newimage.com/~rhk/SDL_gui/"
SRC_URI="http://www.newimage.com/~rhk/SDL_gui/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.4
	>=media-libs/sdl-image-1.0.9
	>=media-libs/sdl-ttf-1.2.1"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README TODO
}
