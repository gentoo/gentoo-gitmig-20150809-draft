# Copyriht 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdlmm/sdlmm-0.1.8.ebuild,v 1.5 2002/07/23 00:49:50 seemant Exp $

MY_P="${P/sdl/SDL}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A C++ Wrapper for the Simple DirectMedia Layer"
SRC_URI="mirror://sourceforge/sdlmm/${MY_P}.tar.bz2"
HOMEPAGE="http://sdlmm.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/libsdl-1.2.4"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING README THANKS
}
