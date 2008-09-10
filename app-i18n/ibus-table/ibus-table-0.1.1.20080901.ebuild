# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-table/ibus-table-0.1.1.20080901.ebuild,v 1.1 2008/09/10 00:18:25 matsuu Exp $

EAPI="1"
inherit eutils

DESCRIPTION="The Table Engine for IBus Framework"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+additional cangjie5 erbi-qs extra-phrases nls wubi zhengma"

RDEPEND="app-i18n/ibus
	>=dev-lang/python-2.5
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.16.1 )"

pkg_setup() {
	if ! built_with_use '>=dev-lang/python-2.5' sqlite; then
		ewarn "You need build dev-lang/python with \"sqlite\" USE flag!"
		die "Please rebuild dev-lang/python with sqlite USE flag!"
	fi
}

src_compile() {
	econf \
		$(use_enable additional) \
		$(use_enable cangjie5) \
		$(use_enable erbi-qs) \
		$(use_enable extra-phrases) \
		$(use_enable wubi wubi86) \
		$(use_enable wubi wubi98) \
		$(use_enable zhengma) \
		$(use_enable nls) || die

	# Parallel make uses a lot of memory to generate databases.
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog
	elog "You should run ibus-setup and enable IM Engines you want to use!"
	elog
}
