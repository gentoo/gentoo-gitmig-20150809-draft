# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdlmm/sdlmm-0.1.8-r1.ebuild,v 1.7 2003/03/10 22:19:43 agriffis Exp $

MY_P="${P/sdl/SDL}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A C++ Wrapper for the Simple DirectMedia Layer"
SRC_URI="mirror://sourceforge/sdlmm/${MY_P}.tar.bz2"
HOMEPAGE="http://sdlmm.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc alpha"

DEPEND=">=media-libs/libsdl-1.2.4"

src_compile() {
	econf || die
	emake LDFLAGS="-lstdc++" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING README THANKS
}
