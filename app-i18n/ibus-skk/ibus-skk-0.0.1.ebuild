# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-skk/ibus-skk-0.0.1.ebuild,v 1.1 2009/12/07 12:44:32 matsuu Exp $

EAPI="2"

inherit python

DESCRIPTION="Japanese input method Anthy IMEngine for IBus Framework"
HOMEPAGE="http://github.com/ueno/ibus-skk"
SRC_URI="http://cloud.github.com/downloads/ueno/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="app-i18n/ibus
	>=dev-lang/python-2.5
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.16.1 )"
RDEPEND="${RDEPEND}
	app-i18n/skk-jisyo"

src_prepare() {
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf $(use_enable nls) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README TODO || die
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
