# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/race/race-0.5.ebuild,v 1.12 2007/03/13 23:25:53 nyhm Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="OpenGL Racing Game"
HOMEPAGE="http://projectz.org/?id=70"
SRC_URI="ftp://users.freebsd.org.uk/pub/foobar2k/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${A}
	cd "${S}"/src
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:g" \
		-e "s:GENTOO_CONFDIR:${GAMES_SYSCONFDIR}:g" \
		*.c || die "sed failed"
	find "${S}"/data/ -type d -name .xvpics -print0 | xargs -0 rm -rf
}

src_compile() {
	emake CC="$(tc-getCC) ${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin race || die "dogamesbin failed"
	insinto "${GAMES_SYSCONFDIR}"
	newins config race.conf || die "newins failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "doins failed"
	newicon data/sea/map.bmp ${PN}.bmp
	make_desktop_entry race Race /usr/share/pixmaps/${PN}.bmp
	dodoc README
	prepgamesdirs
}
