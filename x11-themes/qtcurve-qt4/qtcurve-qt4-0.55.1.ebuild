# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtcurve-qt4/qtcurve-qt4-0.55.1.ebuild,v 1.1 2007/12/03 09:43:08 nelchael Exp $

inherit qt4 cmake-utils

MY_P="${P/qtcurve-qt4/QtCurve-KDE4}"
DESCRIPTION="A set of widget styles for Qt4 based apps, also available for KDE3 and GTK2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://home.freeuk.com/cpdrummond/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="$(qt4_min_version 4.0)"

S="${WORKDIR}/${MY_P}"

src_compile() {
	cmake-utils_src_compile || die "cmake failed"
}

src_install () {
	cmake-utils_src_install || die "make install failed"
	dodoc ChangeLog README TODO
}
