# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-2.6.ebuild,v 1.1 2010/05/16 02:03:03 beandog Exp $

EAPI="2"
inherit cmake-utils

DESCRIPTION="Qt4 Bible study application using the SWORD library."
HOMEPAGE="http://www.bibletime.info/"
SRC_URI="mirror://sourceforge/bibletime/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

# bug 313657
RESTRICT="test"

RDEPEND=">=app-text/sword-1.6.0
	>=dev-cpp/clucene-0.9.16a
	x11-libs/qt-dbus:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4"
DEPEND="${RDEPEND}
	dev-libs/boost
	x11-libs/qt-test:4"

DOCS="ChangeLog README"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DUSE_QT_WEBKIT=ON"
	cmake-utils_src_configure
}
