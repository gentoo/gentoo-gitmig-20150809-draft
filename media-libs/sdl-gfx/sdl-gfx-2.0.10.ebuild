# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-gfx/sdl-gfx-2.0.10.ebuild,v 1.5 2004/01/29 09:33:26 vapier Exp $

inherit flag-o-matic

MY_P="${P/sdl-/SDL_}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Graphics drawing primitives library for SDL"
HOMEPAGE="http://www.ferzkopp.net/~aschiffler/Software/SDL_gfx-2.0/index.html"
SRC_URI="http://www.ferzkopp.net/~aschiffler/Software/SDL_gfx-2.0/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa ~amd64"
IUSE="mmx"

DEPEND=">=media-libs/libsdl-1.2"

src_compile() {
	local myconf

	replace-flags "-O?" "-O2"

	if use ppc || use sparc || use alpha || use amd64
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
