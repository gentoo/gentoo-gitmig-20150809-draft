# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/taxidraw/taxidraw-0.3.2.ebuild,v 1.5 2010/05/25 13:43:54 hwoarang Exp $

EAPI=2
WX_GTK_VER="2.6"
inherit eutils wxwidgets games

MY_P=TaxiDraw-${PV}
DESCRIPTION="a taxiway editor for FlightGear and X-Plane"
HOMEPAGE="http://taxidraw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/wxGTK:2.6[X]
	net-misc/curl"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}"/${P}-gcc41.patch )

src_configure() {
	egamesconf --with-wx-config=${WX_CONFIG}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepgamesdirs
}
