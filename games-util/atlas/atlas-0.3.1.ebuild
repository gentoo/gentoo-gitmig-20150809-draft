# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/atlas/atlas-0.3.1.ebuild,v 1.5 2008/07/22 19:03:34 tupone Exp $

inherit eutils autotools games

MY_P="Atlas-${PV}"
DESCRIPTION="Chart Program to use with Flightgear Flight Simulator"
HOMEPAGE="http://atlas.sourceforge.net/"
SRC_URI="mirror://sourceforge/atlas/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

DEPEND="games-simulation/flightgear
	media-libs/libpng
	media-libs/jpeg
	x11-libs/libXi
	x11-libs/libXmu"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-simgearNew.patch \
		"${FILESDIR}"/${P}-gcc-4.3.patch
	eautoreconf
}

src_compile() {
	egamesconf --with-fgbase="${GAMES_DATADIR}"/FlightGear || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto "${GAMES_DATADIR}"/FlightGear
	doins src/AtlasPalette || die "doins failed"
	keepdir "${GAMES_DATADIR}"/FlightGear/Atlas/lowres
	dodoc AUTHORS NEWS README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "You now can make the maps with the following commands:"
	elog "${GAMES_BINDIR}/Map --atlas=${GAMES_DATADIR}/FlightGear/Atlas"
	elog "${GAMES_BINDIR}/Map --atlas=${GAMES_DATADIR}/FlightGear/Atlas/lowres --size=64"
	elog
	elog "To run Atlas concurrently with FlightGear use the following:"
	elog "Atlas --path=[path of map images] --udp=[port number]"
	elog "and start fgfs with the following switch (or in .fgfsrc):"
	elog "--nmea=socket,out,0.5,[host that you run Atlas on],[port number],udp"
	echo
}

pkg_postrm() {
	elog "You must manually remove the maps if you don't want them around."
	elog "They are found in the following directory:"
	echo
	elog "${GAMES_DATADIR}/FlightGear/Atlas"
	echo
}
