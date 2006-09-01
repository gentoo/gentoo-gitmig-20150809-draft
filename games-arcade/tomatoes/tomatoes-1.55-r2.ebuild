# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tomatoes/tomatoes-1.55-r2.ebuild,v 1.1 2006/09/01 23:45:28 tupone Exp $

inherit eutils games

DATA_PV=1.5
DESCRIPTION="How many tomatoes can you smash in ten short minutes?"
HOMEPAGE="http://tomatoes.sourceforge.net/about.html"
SRC_URI="mirror://sourceforge/tomatoes/tomatoes-linux-src-${PV}.tar.bz2
	mirror://sourceforge/tomatoes/tomatoes-linux-${DATA_PV}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	>=media-libs/libsdl-1.2.7
	>=media-libs/sdl-image-1.2.2
	media-libs/sdl-mixer"

pkg_setup() {
	if ! built_with_use media-libs/sdl-mixer mikmod ; then
		eerror "Tomatoes doesn't work properly if sdl-mixer"
		eerror "is built with USE=-mikmod"
		die "Please emerge sdl-mixer with USE=mikmod"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv ../tomatoes-1.5/* . || die "mv failed"
	mv icon.png ${PN}.png

	sed -i \
		-e '/^CC/d' \
		-e '/^MARCH/d' \
		-e "/^CFLAGS/s/=.*$/= ${CFLAGS} \$(SDL_FLAGS)/" \
		-e "/^LDFLAGS/s/-s$/${LDFLAGS}/" \
		-e "/^MPKDIR = /s:./:${GAMES_DATADIR}/${PN}/:" \
		-e "/^MUSICDIR = /s:./music/:${GAMES_DATADIR}/${PN}/music/:" \
		-e "/^HISCOREDIR = /s:./:${GAMES_STATEDIR}/${PN}/:" \
		-e "/^CONFIGDIR = /s:./:${GAMES_SYSCONFDIR}/${PN}/:" \
		-e "/^OVERRIDEDIR = /s:./data/:${GAMES_DATADIR}/${PN}/data/:" \
		makefile \
		|| die "sed failed"

	epatch "${FILESDIR}"/${P}-c_str.patch
}

src_install() {
	dogamesbin tomatoes || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}" "${GAMES_STATEDIR}/${PN}"
	dodoc README README-src

	cp -r tomatoes.mpk music/ "${D}${GAMES_DATADIR}/${PN}" \
		|| die "failed to copy game data"

	doicon ${PN}.png
	make_desktop_entry tomatoes "I Have No Tomatoes"

	touch "${D}${GAMES_STATEDIR}/${PN}/hiscore.lst" || die "touch failed"
	fperms 660 "${GAMES_STATEDIR}/${PN}/hiscore.lst"

	insinto "${GAMES_SYSCONFDIR}/${PN}/"
	insopts -m0640
	doins config.cfg || die "failed to copy game config"

	prepgamesdirs
}
