# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/fgrun/fgrun-1.0.0.ebuild,v 1.5 2009/10/17 17:34:40 tupone Exp $

EAPI=2
inherit autotools eutils multilib games

DESCRIPTION="A graphical frontend for the FlightGear Flight Simulator"
HOMEPAGE="http://sourceforge.net/projects/fgrun"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-games/simgear
	x11-libs/fltk:1.1[opengl]
	games-simulation/flightgear
	x11-libs/libXi
	x11-libs/libXmu"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}"-{fltk,gcc43}.patch
	AT_M4DIR=. eautoreconf
}

src_configure() {
	egamesconf \
		--with-plib-libraries=/usr/$(get_libdir) \
		--with-plib-includes=/usr/include \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS
	prepgamesdirs
}
