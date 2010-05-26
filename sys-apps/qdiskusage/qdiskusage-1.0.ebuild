# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qdiskusage/qdiskusage-1.0.ebuild,v 1.1 2010/05/26 09:37:50 hwoarang Exp $

EAPI="2"
inherit eutils qt4-r2

MY_PN="QDiskUsage"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Qt4 Graphical Disk Usage Analyzer"
HOMEPAGE="http://www.qt-apps.org/content/show.php/QDiskUsage?content=107012"
SRC_URI="http://qt-apps.org/CONTENT/content-files/107012-${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="app-arch/unzip
	x11-libs/qt-gui:4"
RDEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_install(){
	newbin ${MY_PN} ${PN} || die "newbin failed"
	dodoc README || die "dodoc failed"
}
