# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/netpanzer/netpanzer-0.1.2.ebuild,v 1.1 2003/11/19 08:47:47 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Fast-action multiplayer strategic network game"
HOMEPAGE="http://www.nongnu.org/netpanzer/"
DATAVERSION="0.1.2"
SRC_URI="http://savannah.nongnu.org/download/netpanzer/netpanzer.pkg/0.1/netpanzer-${PV}.tar.bz2
	http://savannah.nongnu.org/download/netpanzer/netpanzer.pkg/0.1/netpanzerdata-${DATAVERSION}.tar.bz2"

KEYWORDS="x86"
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
