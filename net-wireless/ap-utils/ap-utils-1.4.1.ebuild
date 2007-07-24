# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ap-utils/ap-utils-1.4.1.ebuild,v 1.5 2007/07/24 15:36:05 beandog Exp $

inherit eutils

IUSE="nls"

DESCRIPTION="Wireless Access Point Utilities for Unix"
HOMEPAGE="http://ap-utils.polesye.net/"
SRC_URI="mirror://sourceforge/ap-utils/${P}.tar.bz2"
RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND=">=sys-devel/bison-1.34"
RDEPEND=""

src_compile() {
	econf --build=${CHOST} `use_enable nls` || die
	emake || die
}

src_install () {
	einstall || die
	dodoc ChangeLog NEWS README THANKS TODO
}
