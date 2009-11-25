# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-table-zhengma/ibus-table-zhengma-1.1.0.20090402-r1.ebuild,v 1.1 2009/11/25 17:22:54 matsuu Exp $

DESCRIPTION="The ZhengMa for IBus Tables"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extra-phrases"

RDEPEND=">=app-i18n/ibus-table-1.1"
DEPEND="${RDEPEND}
	extra-phrases? ( >=app-i18n/ibus-table-extraphrase-1.1 )
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable extra-phrases) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	rm -rf "${D}"usr/share/doc/${PN} || die

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog
	elog "You should run ibus-setup and enable IM Engines you want to use!"
	elog
}
