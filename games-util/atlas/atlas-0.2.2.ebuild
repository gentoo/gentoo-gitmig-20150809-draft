# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/atlas/atlas-0.2.2.ebuild,v 1.4 2004/03/19 09:30:49 mr_bones_ Exp $

inherit games

MY_P="Atlas-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Chart Program to use with Flightgear Flight Simulator"
HOMEPAGE="http://atlas.sourceforge.net/"
SRC_URI="mirror://sourceforge/atlas/${MY_P}.tar.gz"

INSDESTTREE="/usr/games/lib/FlightGear"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=games-simulation/flightgear-0.8.0
	>=media-libs/libpng-1.2.5
	>=media-libs/plib-1.4
	virtual/glut"

src_compile() {
	egamesconf --with-fgbase=/usr/games/lib/FlightGear || die
	emake || die "emake failed"
}

src_install() {
	doins ${S}/src/AtlasPalette || die
	egamesinstall || die
	keepdir /usr/games/lib/FlightGear/Atlas
	keepdir /usr/games/lib/FlightGear/Atlas/lowres
	dodoc AUTHORS README
	prepgamesdirs
}

pkg_postinst() {
	einfo "You now can make the maps with the following commands:"
	einfo "/usr/games/bin/Map --atlas=/usr/games/lib/FlightGear/Atlas"
	einfo "/usr/games/bin/Map --atlas=/usr/games/lib/FlightGear/Atlas/lowres --size=64"
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
	einfo "/usr/games/lib/FlightGear/Atlas"
	echo
}
