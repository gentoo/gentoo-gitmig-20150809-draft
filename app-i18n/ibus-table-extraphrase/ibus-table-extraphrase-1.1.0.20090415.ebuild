# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-table-extraphrase/ibus-table-extraphrase-1.1.0.20090415.ebuild,v 1.1 2009/04/23 14:04:31 matsuu Exp $

DESCRIPTION="Chinese extra phrases for ibus-table based IME"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-i18n/ibus-table-1.1
	dev-util/pkgconfig"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}
