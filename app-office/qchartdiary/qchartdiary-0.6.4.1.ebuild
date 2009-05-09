# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qchartdiary/qchartdiary-0.6.4.1.ebuild,v 1.1 2009/05/09 15:26:38 hwoarang Exp $

EAPI="2"

inherit qt4

MY_PN="QChartDiary"

DESCRIPTION="Free Qt4 diary/agenda application"
HOMEPAGE="http://qt-apps.org/content/show.php?content=99294"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-sql:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_configure(){
	eqmake4 ${MY_PN}.pro
}

src_install(){
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc AUTHORS CHANGELOG README || die "dodoc failed"
}
