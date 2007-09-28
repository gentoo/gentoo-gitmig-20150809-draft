# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/taxidraw/taxidraw-0.3.2.ebuild,v 1.2 2007/09/28 23:55:33 dirtyepic Exp $

inherit eutils wxwidgets games

MY_P=TaxiDraw-${PV}
DESCRIPTION="a taxiway editor for FlightGear and X-Plane"
HOMEPAGE="http://taxidraw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=x11-libs/wxGTK-2.6*
	net-misc/curl"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	games_pkg_setup
	WX_GTK_VER=2.6 need-wxwidgets gtk2
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	egamesconf --with-wx-config=${WX_CONFIG} || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepgamesdirs
}
