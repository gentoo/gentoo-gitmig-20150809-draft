# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/krystaldrop/krystaldrop-0.7.2.ebuild,v 1.4 2006/05/31 19:34:10 flameeyes Exp $

inherit eutils games

S="${WORKDIR}/${PN}"
DESCRIPTION="Free clone of an excellent NeoGeo puzzle game, Magical Drop"
HOMEPAGE="http://krystaldrop.sourceforge.net/"
SRC_URI="mirror://sourceforge/krystaldrop/art_${PV}.tgz
	mirror://sourceforge/krystaldrop/src_${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="opengl"

RDEPEND="opengl? ( virtual/opengl )
	>=media-libs/libsdl-1.2.5
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	>=dev-libs/libxml2-2.5.7
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack src_${PV}.tgz
	cd ${S}
	epatch "${FILESDIR}/krystaldrop-assert.patch" \
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-deps.patch

	unpack art_${PV}.tgz

	sed -i \
		-e "/^EXEDIR:=/ s|$|/bin|" \
		-e "/^INSTALL_PREFIX:=/ s|$|${D}|" Makefile \
			|| die "sed Makefile failed"

	# fix the high score location
	sed -i \
		-e "s:BINDIR:\"${GAMES_STATEDIR}/${PN}\":" \
			Sources/KrystalDrop/Controller/HighScoresController.cpp \
				|| die "sed HighScoresController.cpp failed"

	if ! use opengl ; then
		sed -i \
			-e "/<opengl>.*<\/opengl>/ s|yes|no|" kdrop.xml \
				|| die "sed kdrop.xml failed"
		sed -i \
			-e '/^USE_OPENGL/ s/yes/no/' Sources/Makefile \
				|| die "sed Sources/Makefile failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodir "${GAMES_STATEDIR}/${PN}"
	mv "${D}${GAMES_DATADIR}/${PN}/art/survival.sco" \
		"${D}${GAMES_STATEDIR}/${PN}/" || die "mv failed"
	fperms 664 "${GAMES_STATEDIR}/${PN}/survival.sco"
	dodoc CHANGES README
	doman doc/kdrop.6
	newicon art/drop.png ${PN}.png
	make_desktop_entry kdrop "KrystalDrop" ${PN}.png

	prepgamesdirs
}
