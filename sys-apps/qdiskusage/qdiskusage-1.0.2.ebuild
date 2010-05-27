# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qdiskusage/qdiskusage-1.0.2.ebuild,v 1.2 2010/05/27 23:01:22 hwoarang Exp $

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

RDEPEND="x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	app-arch/zip"

S="${WORKDIR}/${MY_P}"

src_install(){
	newicon icon.png ${PN} || die "doicon failed"
	newbin ${MY_PN} ${PN} || die "newbin failed"
	dodoc README || die "dodoc failed"
	make_desktop_entry ${PN} "QDiskUsage" ${PN}
}
