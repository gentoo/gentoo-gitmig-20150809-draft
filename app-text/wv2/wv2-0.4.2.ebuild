# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv2/wv2-0.4.2.ebuild,v 1.3 2009/12/17 10:29:21 ssuominen Exp $

EAPI=2

inherit cmake-utils

DESCRIPTION="Excellent MS Word filter lib, used in most Office suites"
HOMEPAGE="http://wvware.sourceforge.net"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="zlib"

RDEPEND=">=gnome-extra/libgsf-1.8
	virtual/libiconv
	zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog README RELEASE THANKS TODO"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with zlib)
	"
	cmake-utils_src_configure
}
