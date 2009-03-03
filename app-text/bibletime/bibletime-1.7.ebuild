# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-1.7.ebuild,v 1.1 2009/03/03 17:02:41 scarabeus Exp $

EAPI=2

inherit kde4-base

DESCRIPTION="KDE Bible study application using the SWORD library."
HOMEPAGE="http://www.bibletime.info/"
SRC_URI="mirror://sourceforge/bibletime/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=app-text/sword-1.5.10
	>=dev-cpp/clucene-0.9.16
	>=x11-libs/qt-webkit-4.4.0:4"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DUSE_QT_WEBKIT=ON"
	kde4-base_src_configure
}
