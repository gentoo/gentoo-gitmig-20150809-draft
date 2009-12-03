# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-2.3.3.ebuild,v 1.3 2009/12/03 10:54:47 maekke Exp $

EAPI=2

inherit cmake-utils

DESCRIPTION="Qt4 Bible study application using the SWORD library."
HOMEPAGE="http://www.bibletime.info/"
SRC_URI="mirror://sourceforge/bibletime/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=app-text/sword-1.6.0
	>=dev-cpp/clucene-0.9.16a
	dev-libs/boost
	>=x11-libs/qt-core-4.4.0:4
	>=x11-libs/qt-dbus-4.4.0:4
	>=x11-libs/qt-gui-4.4.0:4
	>=x11-libs/qt-svg-4.4.0:4
	>=x11-libs/qt-webkit-4.4.0:4"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.0
	>=x11-libs/qt-test-4.4.0:4"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DUSE_QT_WEBKIT=ON"
	cmake-utils_src_configure
}
