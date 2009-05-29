# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-2.0.ebuild,v 1.1 2009/05/29 14:25:49 beandog Exp $

EAPI=2

inherit cmake-utils

DESCRIPTION="Qt Bible study application using the SWORD library."
HOMEPAGE="http://www.bibletime.info/"
SRC_URI="mirror://sourceforge/bibletime/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=app-text/sword-1.5.10
	dev-cpp/clucene
	>=x11-libs/qt-webkit-4.4.0:4"
DEPEND="${RDEPEND}
	dev-util/cmake"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DUSE_QT_WEBKIT=ON"
	cmake-utils_src_configure
}
