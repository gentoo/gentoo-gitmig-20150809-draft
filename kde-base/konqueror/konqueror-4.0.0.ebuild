# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror/konqueror-4.0.0.ebuild,v 1.1 2008/01/18 02:27:41 ingmar Exp $

EAPI="1"

KMNAME=kdebase
KMMODULE=apps/${PN}
inherit kde4-meta

DESCRIPTION="KDE: Web browser, file manager, ..."
IUSE="debug htmlhandbook"
KEYWORDS="~amd64 ~x86"
# Tests fail to compile due to the fact that we compile libkonq seperately.
RESTRICT="test"

DEPEND="
	>=kde-base/libkonq-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	>=kde-base/kdebase-kioslaves-${PV}:${SLOT}
	>=kde-base/kfind-${PV}:${SLOT}"

KMEXTRA="apps/doc/${PN}"
KMEXTRACTONLY="apps/lib/konq/"

PATCHES="${FILESDIR}/${P}-linkage.patch"
#	${FILESDIR}/${P}-linkage-2.patch"

pkg_postinst() {
	echo
	elog "If you want to use konqueror as a filemanager, install the dolphin kpart:"
	elog "emerge kde-base/dolphin:kde-4"
	echo
	elog "To use Java on webpages: emerge >=virtual/jre-1.4"
	echo
}
