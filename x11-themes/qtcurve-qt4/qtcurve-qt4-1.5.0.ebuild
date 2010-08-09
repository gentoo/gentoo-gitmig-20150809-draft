# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtcurve-qt4/qtcurve-qt4-1.5.0.ebuild,v 1.3 2010/08/09 12:46:44 scarabeus Exp $

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

pkg_setup() {
	confutils_use_depend_all windeco kde
	use kde && kde4-base_pkg_setup
}

src_prepare() {
	if use kde && ! use windeco; then
		sed -e "/#include <kdecoration.h>/d" \
			-e "s/if(KDecorationDefines::BorderTiny==size)/if(0==size)/" \
			-i "${S}"/kwin/qtcurveconfig.cpp ||
				die "sed failed"
	fi
}

src_configure() {
	if use kde; then
		kde4-base_src_configure
	else
		mycmakeargs="-DQTC_QT_ONLY=true"
		cmake-utils_src_configure
	fi
}
