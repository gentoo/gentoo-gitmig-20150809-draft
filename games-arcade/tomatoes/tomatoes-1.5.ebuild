# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tomatoes/tomatoes-1.5.ebuild,v 1.2 2004/10/19 02:35:57 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="How many tomatoes can you smash in ten short minutes?"
HOMEPAGE="http://tomatoes.sourceforge.net/about.html"
SRC_URI="mirror://sourceforge/tomatoes/tomatoes-linux-src-${PV}.tar.bz2
	mirror://sourceforge/tomatoes/tomatoes-linux-${PV}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/opengl
	>=media-libs/libsdl-1.2.7
	>=media-libs/sdl-image-1.2.2
	>=media-libs/fmod-3.73"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e '/^CC/d' \
		-e '/^MARCH/d' \
		-e "/^CFLAGS/s/=.*$/= ${CFLAGS} \$(SDL_FLAGS)/" \
		-e "/^MPKDIR = /s:./:${GAMES_DATADIR}/${PN}/:" \
		-e "/^MUSICDIR = /s:./music/:${GAMES_DATADIR}/${PN}/music/:" \
		-e "/^HISCOREDIR = /s:./:${GAMES_STATEDIR}/${PN}/:" \
		-e "/^CONFIGDIR = /s:./:${GAMES_SYSCONFDIR}/${PN}/:" \
		-e "/^OVERRIDEDIR = /s:./data/:${GAMES_DATADIR}/${PN}/data/:" \
		makefile \
		|| die "sed failed"
	epatch "${FILESDIR}/${PV}-gcc34.patch"
}

src_install() {
	dogamesbin tomatoes || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}" "${GAMES_STATEDIR}/${PN}"
	dodoc README README-src

	cp -r tomatoes.mpk music/ "${D}${GAMES_DATADIR}/${PN}" \
		|| die "failed to copy game data"

	insinto /usr/share/icons/
	newins icon.png ${PN}.png
	make_desktop_entry tomatoes "I Have No Tomatoes" ${PN}.png

	touch "${D}${GAMES_STATEDIR}/${PN}/hiscore.lst" || die "touch failed"
	fperms 660 "${GAMES_STATEDIR}/${PN}/hiscore.lst"

	insinto "${GAMES_SYSCONFDIR}/${PN}/"
	insopts -m0640
	doins config.cfg || die "failed to copy game config"

	prepgamesdirs
}
