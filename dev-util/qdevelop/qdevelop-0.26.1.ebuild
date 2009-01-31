# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qdevelop/qdevelop-0.26.1.ebuild,v 1.1 2009/01/31 21:45:26 jokey Exp $

EAPI="2"

inherit base eutils qt4 toolchain-funcs

DESCRIPTION="A development environment entirely dedicated to Qt4."
HOMEPAGE="http://qdevelop.org/"
SRC_URI="http://qdevelop.org/public/release/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="
	|| ( 
	( x11-libs/qt-gui:4 x11-libs/qt-sql:4 )
	>=x11-libs/qt-4.2:4 )"


QT4_BUILT_WITH_USE_CHECK="sqlite3"

src_configure() {
	eqmake4 QDevelop.pro
}

src_compile() {
	emake CXX=$(tc-getCXX) || die "emake failed"
}

src_install() {
	dodoc ChangeLog.txt README.txt || die "dodoc failed"
	dobin bin/qdevelop || die "dobin failed"
	newicon "${S}"/resources/images/QDevelop.png qdevelop.png
	domenu "${FILESDIR}"/qdevelop.desktop
}
