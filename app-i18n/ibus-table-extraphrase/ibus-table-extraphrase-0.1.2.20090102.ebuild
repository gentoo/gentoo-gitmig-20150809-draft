# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-table-extraphrase/ibus-table-extraphrase-0.1.2.20090102.ebuild,v 1.2 2009/02/05 16:10:19 matsuu Exp $

DESCRIPTION="Chinese extra phrases for ibus-table based IME"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=app-i18n/ibus-table-0.1*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}
