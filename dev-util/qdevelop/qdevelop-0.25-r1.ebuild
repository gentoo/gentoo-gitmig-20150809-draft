# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qdevelop/qdevelop-0.25-r1.ebuild,v 1.5 2008/07/23 13:08:32 loki_val Exp $

EAPI="1"
inherit base eutils qt4 toolchain-funcs

DESCRIPTION="A development environment entirely dedicated to Qt4."
HOMEPAGE="http://qdevelop.org/"
SRC_URI="http://qdevelop.free.fr/download/${PN}_${PV}.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
SLOT="0"
IUSE=""

RDEPEND="
	|| ( ( x11-libs/qt-gui:4
		x11-libs/qt-sql:4 )
	>=x11-libs/qt-4.2:4 )"
DEPEND="app-arch/unzip
		${RDEPEND}"

QT4_BUILT_WITH_USE_CHECK="sqlite3"

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

src_compile() {
	eqmake4 QDevelop.pro
	emake CXX=$(tc-getCXX) || die "emake failed"
}

src_install() {
	dodoc ChangeLog.txt README.txt
	dobin bin/qdevelop
	newicon "${S}"/resources/images/QDevelop.png qdevelop.png
	domenu "${FILESDIR}"/qdevelop.desktop
}
