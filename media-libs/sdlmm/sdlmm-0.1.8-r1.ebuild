# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdlmm/sdlmm-0.1.8-r1.ebuild,v 1.12 2004/08/31 23:53:34 mr_bones_ Exp $

MY_P="${P/sdl/SDL}"
DESCRIPTION="A C++ Wrapper for the Simple DirectMedia Layer"
HOMEPAGE="http://sdlmm.sourceforge.net/"
SRC_URI="mirror://sourceforge/sdlmm/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.4"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die
	emake LDFLAGS="-lstdc++" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README THANKS
}
