# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/epiar/epiar-0.5.ebuild,v 1.3 2004/03/28 20:32:04 mr_bones_ Exp $

inherit flag-o-matic games

DESCRIPTION="A space adventure/combat game"
HOMEPAGE="http://epiar.net/"
SRC_URI="mirror://sourceforge/epiar/${P}.0-src.zip"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="alsa"

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
	>=sys-apps/sed-4
	app-arch/unzip"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^CFLAGS/s:-pg -g:${CFLAGS}:" Makefile.linux \
			|| die "sed Makefile.linux failed"
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	sed -i \
		-e "s:GENTOO_DATAPATH:${GAMES_DATADIR}/${PN}/:" src/system/path.c \
			|| die "sed src/system/path.c failed"
}

src_compile() {
	emake -f Makefile.linux || die "emake failed"
}

src_install() {
	dogamesbin epiar || die "dogamesbin failed"

	insinto ${GAMES_DATADIR}/${PN}
	doins *.eaf || die "doins failed"
	insinto ${GAMES_DATADIR}/${PN}/missions
	doins missions/*.eaf || die "doins failed (missions)"
	dodir ${GAMES_DATADIR}/${PN}/plugins

	dodoc AUTHORS ChangeLog README

	prepgamesdirs
}
