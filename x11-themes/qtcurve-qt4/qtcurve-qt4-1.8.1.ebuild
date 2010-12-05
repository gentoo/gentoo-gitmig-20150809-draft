# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtcurve-qt4/qtcurve-qt4-1.8.1.ebuild,v 1.1 2010/12/05 22:49:10 wired Exp $

EAPI="2"
KDE_REQUIRED="optional"
inherit confutils cmake-utils kde4-base

MY_P="${P/qtcurve-qt4/QtCurve-KDE4}"
DESCRIPTION="A set of widget styles for Qt4 based apps, also available for GTK2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://craigd.wikispaces.com/file/view/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="kde windeco"

DEPEND="x11-libs/qt-gui:4[dbus]
	x11-libs/qt-svg:4
	kde? ( >=kde-base/systemsettings-${KDE_MINIMAL}
		windeco? ( >=kde-base/kwin-${KDE_MINIMAL} ) )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
DOCS="ChangeLog README TODO"

PATCHES=( "${FILESDIR}/${PN}_kwin_automagic_fix.patch" )

pkg_setup() {
	if ! use kde && use windeco; then
		ewarn
		ewarn "Auto-disabling the windeco USE flag since it requires the kde USE"
		ewarn "flag. To fix this, please enable the kde USE flag."
		ewarn
	fi
	use kde && kde4-base_pkg_setup
}

src_configure() {
	if use kde; then
		mycmakeargs="$(use windeco && echo "-DQTC_KWIN=true")"
		kde4-base_src_configure
	else
		mycmakeargs="-DQTC_QT_ONLY=true"
		cmake-utils_src_configure
	fi
}
