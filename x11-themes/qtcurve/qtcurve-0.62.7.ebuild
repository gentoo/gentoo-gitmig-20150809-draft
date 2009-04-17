# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtcurve/qtcurve-0.62.7.ebuild,v 1.1 2009/04/17 10:11:55 yngwin Exp $

EAPI=1

# Order is important, so we get src_compile from cmake-utils.
inherit kde-functions qt3 cmake-utils

MY_P=${P/qtcurve/QtCurve-KDE3}

DESCRIPTION="A set of widget styles for KDE3 based apps, also available for GTK2 and Qt4"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://home.freeuk.com/cpdrummond/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/qt:3"
DEPEND="${RDEPEND}"

need-kde 3.5

S=${WORKDIR}/${MY_P}
DOCS="ChangeLog README TODO"

pkg_postinst() {
	buildsycoca
}

pkg_postrm() {
	buildsycoca
}
