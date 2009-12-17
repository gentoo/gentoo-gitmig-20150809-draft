# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtcurve-qt4/qtcurve-qt4-0.59.6.ebuild,v 1.13 2009/12/17 18:24:02 ssuominen Exp $

EAPI="1"
inherit flag-o-matic cmake-utils

MY_P="${P/qtcurve-qt4/QtCurve-KDE4}"
DESCRIPTION="A set of widget styles for Qt4 based apps, also available for KDE3 and GTK2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://home.freeuk.com/cpdrummond/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

S="${WORKDIR}/${MY_P}"
DOCS="ChangeLog README TODO"

src_compile() {
	append-cppflags "-DQTC_NO_KDE4_LINKING=true -DQTC_DISABLE_KDEFILEDIALOG_CALLS=true";
	sed -i "s/find_package(KDE4)/#&/" "${S}"/CMakeLists.txt
	cmake-utils_src_compile
}
