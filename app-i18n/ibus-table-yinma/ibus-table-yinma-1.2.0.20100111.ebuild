# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-table-yinma/ibus-table-yinma-1.2.0.20100111.ebuild,v 1.2 2012/05/03 19:24:27 jdhore Exp $

DESCRIPTION="The yinma tables for IBus-Table"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/ibus-table-1.2.0.20100111
	!app-i18n/ibus-table-erbi
	!app-i18n/ibus-table-wu
	!app-i18n/ibus-table-yong
	!app-i18n/ibus-table-zhuyin
	!app-i18n/ibus-table-ziranma"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README || die
}
