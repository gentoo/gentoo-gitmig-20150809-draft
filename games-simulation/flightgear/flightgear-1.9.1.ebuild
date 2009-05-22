# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/flightgear/flightgear-1.9.1.ebuild,v 1.3 2009/05/22 07:02:27 tupone Exp $

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
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="sdl"

RDEPEND="virtual/glut
	~dev-games/simgear-1.9.1
	dev-games/openscenegraph
	x11-libs/libXmu"
DEPEND="${RDEPEND}"

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
		$(use_enable sdl) \
		|| die "configure failed"
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
