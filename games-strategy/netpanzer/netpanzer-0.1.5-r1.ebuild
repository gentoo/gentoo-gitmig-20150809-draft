# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/netpanzer/netpanzer-0.1.5-r1.ebuild,v 1.2 2004/08/03 11:55:41 dholm Exp $

inherit eutils games

DESCRIPTION="Fast-action multiplayer strategic network game"
HOMEPAGE="http://netpanzer.berlios.de/"
DATAVERSION="0.1.3"
SRC_URI="http://download.berlios.de/netpanzer/netpanzer-${PV}.tar.bz2
	http://download.berlios.de/netpanzer/netpanzerdata-${DATAVERSION}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
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

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/${PN}data-${DATAVERSION}/"
	epatch "${FILESDIR}/physfs.patch"
	./autogen.sh
}

src_compile() {
	# bug #57332 - netpanzeredit isn't ready yet.
	egamesconf \
		--with-wx-config=none \
		|| die
	jam || die "jam failed"

	einfo "Working in ${WORKDIR}/${PN}data-${DATAVERSION}/"
	cd ${WORKDIR}/${PN}data-${DATAVERSION}/
	egamesconf || die
	jam || die "jam failed (on data package)"
}

src_install() {
	jam -sDESTDIR="${D}" install || die "jam install failed"

	# Don't use DESTDIR yet, because 0.1.3 didn't support that yet
	cd "${WORKDIR}/${PN}data-${DATAVERSION}/" \
		&& jam -sdatadir="${D}${GAMES_DATADIR}" install \
		|| die "jam install failed (data package)"
	dodoc ChangeLog README TODO
	prepgamesdirs
}
