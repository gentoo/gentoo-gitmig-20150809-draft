# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/flightgear/flightgear-1.9.1.ebuild,v 1.10 2011/02/26 13:30:27 armin76 Exp $

EAPI=2
inherit autotools eutils games

MY_PN=FlightGear
MY_P=${MY_PN}-${PV}
DESCRIPTION="Open Source Flight Simulator"
HOMEPAGE="http://www.flightgear.org/"
SRC_URI="mirror://flightgear/Source/${MY_P}.tar.gz
	mirror://flightgear/Shared/${MY_PN}-data-1.9.0.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="sdl"

DEPEND="media-libs/freeglut
	~dev-games/simgear-1.9.1
	dev-games/openscenegraph[png]
	x11-libs/libXmu"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-sdl.patch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-parallel.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable sdl)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto "${GAMES_DATADIR}"/${MY_PN}
	doins -r ../data/* || die "doins failed"
	newicon ../data/Aircraft/A6M2/thumbnail.jpg ${PN}.jpg
	make_desktop_entry fgfs FlightGear /usr/share/pixmaps/${PN}.jpg
	dodoc AUTHORS ChangeLog NEWS README Thanks
	prepgamesdirs
}
