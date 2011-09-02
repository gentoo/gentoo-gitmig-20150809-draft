# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/searchmonkey/searchmonkey-2.0.0.ebuild,v 1.1 2011/09/02 23:34:43 sping Exp $

EAPI="3"

inherit qt4-r2

MY_PN=${PN}2
MY_P=${PN}_v${PV}
DESCRIPTION="Powerful text searches using regular expressions"
HOMEPAGE="http://searchmonkey.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${PN}/${MY_PN^}/${PV}%20%5Bstable%5D/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui
	x11-libs/qt-core"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"/${MY_P}

src_install() {
	newbin ${PN} ${MY_PN} || die

	# Hand-made desktop icon
	insinto /usr/share/pixmaps/
	doins pixmaps/searchmonkey-300x300.png || die
	insinto /usr/share/applications/
	doins "${FILESDIR}"/${P}.desktop || die
}
