# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/netpanzer/netpanzer-0.1.5.ebuild,v 1.1 2004/03/06 00:45:36 mr_bones_ Exp $

inherit eutils games

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
	jam -sDESTDIR="${D}" install || die "jam install failed"

	cd ${WORKDIR}/${PN}data-${DATAVERSION}/ &&
	# Don't use DESTDIR yet, because 0.1.3 didn't support that yet
	jam -sdatadir="${D}${GAMES_DATADIR}" install \
		|| die "jam install failed (data package)"
	prepgamesdirs
}
