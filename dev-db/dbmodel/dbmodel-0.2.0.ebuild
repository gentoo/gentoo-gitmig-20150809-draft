# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/dbmodel/dbmodel-0.2.0.ebuild,v 1.2 2009/09/11 11:23:14 flameeyes Exp $

EAPI="2"

inherit qt4

DESCRIPTION="Qt4 tool for drawing entity-relational diagrams"
HOMEPAGE="http://qt-apps.org/content/show.php/Database+Modeller?content=100376"
SRC_URI="http://launchpad.net/dbmodel/trunk/0.2.0/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4[debug?]"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4 ${PN}.pro PREFIX=/usr
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc AUTHORS CHANGES || die "dodoc failed"
}
