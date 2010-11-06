# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlitebrowser/sqlitebrowser-2.00_beta1.ebuild,v 1.2 2010/11/06 12:13:13 xmw Exp $

EAPI=2
inherit eutils qt4

DESCRIPTION="SQLite Database Browser"
HOMEPAGE="http://sqlitebrowser.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_200_b1_src.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=x11-libs/qt-gui-4.6*:4[qt3support]"

S=${WORKDIR}/trunk/${PN}

src_configure() {
	eqmake4 sqlitedbbrowser.pro
}

src_install() {
	dobin ${PN}/${PN} || die
	newicon ${PN}/images/128.png ${PN}.png
	make_desktop_entry ${PN} "SQLite Database Browser"
}
