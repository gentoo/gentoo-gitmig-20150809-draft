# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/qvortaro/qvortaro-0.4.1.ebuild,v 1.1 2010/01/27 11:50:51 ssuominen Exp $

EAPI=2
inherit eutils qt4-r2

DESCRIPTION="Esperanto Dictionary"
HOMEPAGE="http://qvortaro.berlios.de/"
SRC_URI="mirror://berlios/qvortaro/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-sql:4"

src_install() {
	dobin qvortaro || die
	newicon src/img/icon_16.png ${PN}.png
	make_desktop_entry ${PN} qVortaro
	dodoc readme.txt
}
