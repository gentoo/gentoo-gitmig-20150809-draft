# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/freedroidrpg/freedroidrpg-0.9.5_p1.ebuild,v 1.1 2003/09/10 06:26:50 vapier Exp $

inherit games

MY_PV=${PV/_p/-patchlv}
DESCRIPTION="Freedroid - a Paradroid clone"
HOMEPAGE="http://freedroid.sourceforge.net/"
SRC_URI="mirror://sourceforge/freedroid/freedroidrpg-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND=">=media-libs/libsdl-1.1.5
	media-libs/jpeg
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-image
	media-libs/sdl-net
	media-libs/sdl-mixer
	virtual/x11"

S=${WORKDIR}/freedroidRPG-${PV/_p1}

src_unpack() {
	unpack ${A}
	cd ${S}
	make distclean || die # who the hell does this ??
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
