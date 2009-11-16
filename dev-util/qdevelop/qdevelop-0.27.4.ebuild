# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qdevelop/qdevelop-0.27.4.ebuild,v 1.1 2009/11/16 15:22:55 spatz Exp $

EAPI="2"

inherit eutils qt4

DESCRIPTION="A development environment entirely dedicated to Qt4."
HOMEPAGE="http://qdevelop.org/"
SRC_URI="http://qdevelop.org/public/release/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-sql:4[sqlite]"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4 QDevelop.pro
}

src_install() {
	dodoc ChangeLog.txt README.txt || die "dodoc failed"
	dobin bin/qdevelop || die "dobin failed"
	newicon "${S}"/resources/images/QDevelop.png qdevelop.png
	domenu "${FILESDIR}"/qdevelop.desktop
}

pkg_postinst(){
	elog "Additional functionality can be achieved by emerging other packages:"
	elog "  dev-util/ctags - code completion"
	elog "  sys-devel/gdb - debugging"
}
