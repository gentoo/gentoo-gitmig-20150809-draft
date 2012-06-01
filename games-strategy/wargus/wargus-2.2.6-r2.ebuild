# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wargus/wargus-2.2.6-r2.ebuild,v 1.1 2012/06/01 20:21:09 hasufell Exp $

EAPI=2
inherit eutils cmake-utils gnome2-utils games

DESCRIPTION="Warcraft II for the Stratagus game engine"
HOMEPAGE="http://wargus.sourceforge.net/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=games-engines/stratagus-${PV}*[theora]
	media-libs/freetype
	media-libs/libpng:0
	sys-libs/zlib
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
PDEPEND="games-strategy/wargus-data"

S=${WORKDIR}/${PN}_${PV}.orig

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.2.5.5-libpng.patch" \
		"${FILESDIR}/${P}-build.patch" \
		"${FILESDIR}/${P}-underlinking.patch"

	sed \
		-e "/^Exec/s#/usr/games/wargus#${GAMES_BINDIR}/wargus#" \
		-i wargus.desktop || die "fixing desktop file failed"
}

src_configure() {
	local mycmakeargs=(
		-DBINDIR="${GAMES_BINDIR}"
		-DSTRATAGUS="${GAMES_BINDIR}"/stratagus
		-DICONDIR=/usr/share/icons/hicolor/64x64/apps
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	elog "Enabling OpenGL in-game seems to cause segfaults/crashes."
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
