# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-kde4/gtk-engines-kde4-0.9e.ebuild,v 1.1 2009/10/19 16:26:02 ssuominen Exp $

EAPI=2
inherit kde4-base

MY_PN=gtk-kde4

DESCRIPTION="GTK+2 Qt4 Theme Engine"
HOMEPAGE="http://kde-apps.org/content/show.php/gtk-kde4?content=74689"
SRC_URI="http://betta.houa.org/no-site/${MY_PN}v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/qt-gui-4.4.2:4
	>=x11-libs/qt-svg-4.4.2:4
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-CMakeLists.patch" )

S=${WORKDIR}/${MY_PN}

src_prepare() {
	# remove redundant makefile shipped with package
	# just for avoiding confusion
	rm -rf Makefile
	kde4-base_src_prepare
}

pkg_postinst() {
	kde4-base_pkg_postinst
	elog "If you want additional themes just download:"
	elog "http://betta.h.com.ua/no-site/qt4.tar.gz"
	elog "and put into ~/.themes/ or just use any nice gtk theme."
}
