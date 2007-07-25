# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/fgrun/fgrun-0.4.8.ebuild,v 1.2 2007/07/25 09:27:29 opfer Exp $

inherit autotools eutils games

DESCRIPTION="A graphical frontend to run FlightGear Flight Simulator."
HOMEPAGE="http://sourceforge.net/projects/fgrun"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-games/simgear
	x11-libs/fltk
	games-simulation/flightgear
	x11-libs/libXi
	x11-libs/libXmu"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-fltk.patch
	AT_M4DIR=. eautoreconf
}

src_compile() {
	egamesconf --with-plib-libraries=/usr/$(get_libdir) --with-plib-includes=/usr/include || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS

	prepgamesdirs
}
