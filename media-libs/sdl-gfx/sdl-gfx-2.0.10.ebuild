# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-gfx/sdl-gfx-2.0.10.ebuild,v 1.1 2003/12/11 22:46:04 mr_bones_ Exp $

inherit flag-o-matic

MY_P=${P/sdl-/SDL_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Graphics drawing primitives library for SDL"
HOMEPAGE="http://www.ferzkopp.net/~aschiffler/Software/SDL_gfx-2.0/index.html"
SRC_URI="http://www.ferzkopp.net/~aschiffler/Software/SDL_gfx-2.0/${MY_P}.tar.gz"

KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND=">=media-libs/libsdl-1.2"

src_compile() {
	local myconf

	replace-flags "-O?" "-O2"

	if use ppc || use sparc || use alpha
	then
		myconf="--disable-mmx"
	else
		use mmx || myconf="--disable-mmx"
	fi

	econf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	einstall                       || die
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
	dohtml -r Docs/*               || die "dohtml failed"
}
