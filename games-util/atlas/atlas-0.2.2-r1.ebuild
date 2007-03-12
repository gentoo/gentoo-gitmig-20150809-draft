# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/atlas/atlas-0.2.2-r1.ebuild,v 1.6 2007/03/12 18:20:22 genone Exp $

inherit eutils games

MY_P="Atlas-${PV}"
DESCRIPTION="Chart Program to use with Flightgear Flight Simulator"
HOMEPAGE="http://atlas.sourceforge.net/"
SRC_URI="mirror://sourceforge/atlas/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~sparc x86"
IUSE=""

DEPEND=">=games-simulation/flightgear-0.9.4
	>=media-libs/libpng-1.2.5
	>=media-libs/plib-1.4
	virtual/glut"

S=${WORKDIR}/${MY_P}

INSDESTTREE="${GAMES_LIBDIR}/FlightGear"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-fix.patch"
}

src_compile() {
	egamesconf --with-fgbase="${GAMES_LIBDIR}/FlightGear" || die
	emake || die "emake failed"
}

src_install() {
	doins "${S}/src/AtlasPalette" || die
	egamesinstall || die
	keepdir "${GAMES_LIBDIR}/FlightGear/Atlas/lowres"
	dodoc AUTHORS README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "You now can make the maps with the following commands:"
	elog "${GAMES_BINDIR}/Map --atlas=${GAMES_LIBDIR}/FlightGear/Atlas"
	elog "${GAMES_BINDIR}/Map --atlas=${GAMES_LIBDIR}/FlightGear/Atlas/lowres --size=64"
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
	elog "${GAMES_LIBDIR}/FlightGear/Atlas"
	echo
}
