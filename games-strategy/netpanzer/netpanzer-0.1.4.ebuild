# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/netpanzer/netpanzer-0.1.4.ebuild,v 1.1 2004/02/22 15:23:08 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Fast-action multiplayer strategic network game"
HOMEPAGE="http://netpanzer.berlios.de/"
DATAVERSION="0.1.3"
SRC_URI="http://download.berlios.de/netpanzer/netpanzer-${PV}.tar.bz2
	http://download.berlios.de/netpanzer/netpanzerdata-${DATAVERSION}.tar.bz2"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.5
	>=media-libs/sdl-net-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-ttf-2.0.0
	>=dev-games/physfs-0.1.9
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	>=dev-util/jam-2.5"

src_compile() {
	egamesconf || die
	jam        || die "jam failed"

	cd ${WORKDIR}/${PN}data-${DATAVERSION}/
	egamesconf || die
	jam        || die "jam failed (on data package)"
}

src_install() {
	# don't put a '/' between ${D} and ${GAMES_PREFIX} because of a jam bug
	# (more than 3 continuos slashes don't work
	jam -sprefix=${D}${GAMES_PREFIX} \
		-sdatadir=${D}${GAMES_DATADIR} \
		-smandir=${D}/usr/share/man install || die "jam install failed"

	cd ${WORKDIR}/${PN}data-${DATAVERSION}/ &&
	jam -sprefix=${D}${GAMES_PREFIX} \
		-sdatadir=${D}${GAMES_DATADIR} \
		-smandir=${D}/usr/share/man install || die "jam install failed (on data package)"
	prepgamesdirs
}
