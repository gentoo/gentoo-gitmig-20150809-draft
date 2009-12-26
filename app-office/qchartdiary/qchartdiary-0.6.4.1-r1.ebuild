# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qchartdiary/qchartdiary-0.6.4.1-r1.ebuild,v 1.1 2009/12/26 10:55:11 hwoarang Exp $

EAPI="2"

inherit qt4-r2

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

DOCS="AUTHORS CHANGELOG README"

src_prepare() {
	sed -i "s/doc\/${MY_PN}/doc\/${PF}/" ${MY_PN}.pro \
		|| die "failed to fix documentation path"
	qt4-r2_src_prepare
}
