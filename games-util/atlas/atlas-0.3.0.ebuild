# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/atlas/atlas-0.3.0.ebuild,v 1.3 2006/12/06 21:14:26 wolf31o2 Exp $

inherit eutils games

MY_P="Atlas-${PV}"
DESCRIPTION="Chart Program to use with Flightgear Flight Simulator"
HOMEPAGE="http://atlas.sourceforge.net/"
SRC_URI="mirror://sourceforge/atlas/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=games-simulation/flightgear-0.9.4
	>=media-libs/libpng-1.2.5
	media-libs/jpeg
	x11-libs/libXi
	x11-libs/libXmu"

S=${WORKDIR}/${MY_P}

src_compile() {
	egamesconf --with-fgbase="${GAMES_DATADIR}/FlightGear" \
		|| die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	insinto ${GAMES_DATADIR}/FlightGear
	doins "${S}/src/AtlasPalette" || die "doins failed"
	keepdir "${GAMES_DATADIR}/FlightGear/Atlas/lowres"
	dodoc AUTHORS NEWS README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	einfo "You now can make the maps with the following commands:"
	einfo "${GAMES_BINDIR}/Map --atlas=${GAMES_DATADIR}/FlightGear/Atlas"
	einfo "${GAMES_BINDIR}/Map --atlas=${GAMES_DATADIR}/FlightGear/Atlas/lowres --size=64"
	echo
	einfo "To run Atlas concurrently with FlightGear use the following:"
	einfo "Atlas --path=[path of map images] --udp=[port number]"
	einfo "and start fgfs with the following switch (or in .fgfsrc):"
	einfo "--nmea=socket,out,0.5,[host that you run Atlas on],[port number],udp"
	echo
}

pkg_postrm() {
	einfo "You must manually remove the maps if you don't want them around."
	einfo "They are found in the following directory:"
	echo
	einfo "${GAMES_DATADIR}/FlightGear/Atlas"
	echo
}
