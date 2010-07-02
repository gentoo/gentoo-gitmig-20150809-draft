# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-skk/ibus-skk-0.0.9.ebuild,v 1.1 2010/07/02 16:32:51 matsuu Exp $

EAPI="2"
PYTHON_DEPEND="2:2.5"
inherit python

DESCRIPTION="Japanese input method Anthy IMEngine for IBus Framework"
HOMEPAGE="http://github.com/ueno/ibus-skk"
SRC_URI="http://cloud.github.com/downloads/ueno/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="app-i18n/ibus
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.16.1 )"
RDEPEND="${RDEPEND}
	app-i18n/skk-jisyo"

pkg_setup() {
	python_set_active_version 2

}

src_prepare() {
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf $(use_enable nls) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
