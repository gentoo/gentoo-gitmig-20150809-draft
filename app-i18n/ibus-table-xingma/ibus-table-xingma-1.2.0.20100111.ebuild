# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-table-xingma/ibus-table-xingma-1.2.0.20100111.ebuild,v 1.2 2012/05/03 19:24:31 jdhore Exp $

DESCRIPTION="The xingma tables for IBus-Table"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extra-phrases"

RDEPEND=">=app-i18n/ibus-table-1.2
	!app-i18n/ibus-table-stroke5
	!app-i18n/ibus-table-wubi
	!app-i18n/ibus-table-xinhua
	!app-i18n/ibus-table-zhengma"
DEPEND="${RDEPEND}
	extra-phrases? ( >=app-i18n/ibus-table-extraphrase-1.1 )
	virtual/pkgconfig"

src_compile() {
	econf $(use_enable extra-phrases) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}
