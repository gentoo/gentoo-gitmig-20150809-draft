# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/netpanzer/netpanzer-0.1.1.ebuild,v 1.2 2004/01/05 23:17:14 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Fast-action multiplayer strategic network game"
HOMEPAGE="http://www.nongnu.org/netpanzer/"
SRC_URI="http://savannah.nongnu.org/download/netpanzer/netpanzer.pkg/0.1/netpanzer-${PV}.tar.bz2
	http://savannah.nongnu.org/download/netpanzer/netpanzer.pkg/0.1/netpanzerdata-0.1.tar.bz2"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

RDEPEND=">=media-libs/libsdl-1.2.5
	>=media-libs/sdl-net-1.2.4
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-image-1.2.3
	>=dev-games/physfs-0.1.9
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	>=dev-util/jam-2.5"

src_compile() {
	egamesconf || die
	jam        || die "jam failed"

	cd ${WORKDIR}/${PN}data-0.1/
	egamesconf || die
	jam        || die "jam failed (2)"
}

src_install() {
	# don't put a '/' between ${D} and ${GAMES_PREFIX} because of a jam bug
	# (more than 3 continuos slashes don't work
	jam -sprefix=${D}${GAMES_PREFIX} \
		-sdatadir=${D}${GAMES_DATADIR} install || die "jam install failed"

	cd ${WORKDIR}/${PN}data-0.1/
	jam -sprefix=${D}${GAMES_PREFIX} \
		-sdatadir=${D}${GAMES_DATADIR} install || die "jam install failed (2)"
	prepgamesdirs
}
