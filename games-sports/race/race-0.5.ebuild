# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/race/race-0.5.ebuild,v 1.14 2010/09/09 16:37:31 mr_bones_ Exp $

EAPI=2
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
	media-libs/libsdl[audio,opengl,video]
	media-libs/sdl-image[jpeg,png]
	media-libs/sdl-mixer[mikmod]"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-gentoo.patch \
		"${FILESDIR}"/${P}-ldflags.patch
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:g" \
		-e "s:GENTOO_CONFDIR:${GAMES_SYSCONFDIR}:g" \
		src/*.c || die "sed failed"
	find data/ -type d -name .xvpics -print0 | xargs -0 rm -rf
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
