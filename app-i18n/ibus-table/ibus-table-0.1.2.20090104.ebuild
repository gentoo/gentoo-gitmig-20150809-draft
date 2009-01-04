# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-table/ibus-table-0.1.2.20090104.ebuild,v 1.1 2009/01/04 13:51:53 matsuu Exp $

inherit eutils python

DESCRIPTION="The Table Engine for IBus Framework"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal nls"

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

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_compile() {
	econf \
		$(use_enable !minimal additional) \
		$(use_enable nls) || die
	emake || die
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
	python_mod_optimize /usr/share/${PN}/engine
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}/engine
}
