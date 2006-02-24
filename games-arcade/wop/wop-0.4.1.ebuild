# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/wop/wop-0.4.1.ebuild,v 1.1 2006/02/24 09:53:24 mr_bones_ Exp $

inherit eutils games

MY_DATA_V="2005-12-21"
MY_DATA_P="${PN}data-${MY_DATA_V}"

DESCRIPTION="Worms of Prey - A multi-player, real-time clone of Worms"
HOMEPAGE="http://wormsofprey.org/"
SRC_URI="http://wormsofprey.org/download/${P}-src.tar.bz2
	http://wormsofprey.org/download/${MY_DATA_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/zlib
	>=media-libs/libsdl-1.2
	>=media-libs/sdl-net-1.2.5
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-ttf-2.0"

MY_DATA_S=${WORKDIR}/${MY_DATA_P}

src_unpack() {
	unpack ${A}

	# correct path to global woprc
	sed -i \
		-e "s:/etc/woprc:${GAMES_SYSCONFDIR}/woprc:g" \
		"${S}/src/wopsettings.cpp" \
		|| die "sed failed"

	# patch global woprc with the correct data files location and install it
	sed -i \
		-e "s:^data =.*$:data = ${GAMES_DATADIR}/${PN}:" \
		"${S}/woprc" \
		|| die "sed failed"
}

src_install() {
	dogamesbin bin/${PN} || die "dogamesbin failed"

	newicon "${MY_DATA_S}/images/misc/icons/wop16.png" ${PN}.png
	make_desktop_entry wop "Worms of Prey"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r "${MY_DATA_S}"/* || die "doins failed"

	dodoc AUTHORS ChangeLog PACKAGE_MAINTAINERS README{,-Libraries.txt} REVIEWS

	insinto "${GAMES_SYSCONFDIR}"
	doins "${S}/woprc" || die "doins failed"

	prepgamesdirs
}
