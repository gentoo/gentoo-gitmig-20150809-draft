# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/epiar/epiar-0.5.ebuild,v 1.1 2004/03/28 09:59:55 vapier Exp $

inherit games flag-o-matic

DESCRIPTION="A space adventure/combat game"
HOMEPAGE="http://epiar.net/"
SRC_URI="mirror://sourceforge/epiar/epiar-0.5.0-src.zip"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="alsa debug"

RDEPEND="virtual/x11
	virtual/glibc
	media-libs/aalib
	media-libs/jpeg
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-image
	sys-libs/ncurses
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )"	
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "/^CFLAGS/s:-pg -g:${CFLAGS}:" Makefile.linux
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	sed -i "s:GENTOO_DATAPATH:${GAMES_DATADIR}/${PN}/:" src/system/path.c
}

src_compile() {
	emake -f Makefile.linux || die
}

src_install() {
	dogamesbin epiar || die

	insinto ${GAMES_DATADIR}/${PN}
	doins *.eaf || die
	insinto ${GAMES_DATADIR}/${PN}/missions
	doins missions/*.eaf
	dodir ${GAMES_DATADIR}/${PN}/plugins

	dodoc AUTHORS ChangeLog README
	
	prepgamesdirs
}
