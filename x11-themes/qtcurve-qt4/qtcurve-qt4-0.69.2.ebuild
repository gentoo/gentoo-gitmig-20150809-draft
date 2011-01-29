# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtcurve-qt4/qtcurve-qt4-0.69.2.ebuild,v 1.10 2011/01/29 18:12:52 scarabeus Exp $

EAPI=3
KDE_REQUIRED="optional"
inherit flag-o-matic cmake-utils kde4-base

MY_P="${P/qtcurve-qt4/QtCurve-KDE4}"
DESCRIPTION="A set of widget styles for Qt4 based apps, also available for KDE3 and GTK2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://craigd.wikispaces.com/file/view/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ~ppc64 sparc x86"
IUSE="kde"

DEPEND="x11-libs/qt-gui:4[dbus]
	kde? ( >=kde-base/kwin-${KDE_MINIMAL} )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
DOCS="ChangeLog README TODO"

src_configure() {
	if use kde ; then
		kde4-base_src_configure
	else
		mycmakeargs="-DQTC_QT_ONLY=true"
		cmake-utils_src_configure
	fi
}
