# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-sunpinyin/ibus-sunpinyin-2.0.20091104.ebuild,v 1.1 2009/11/08 03:49:53 matsuu Exp $

EAPI="2"

inherit python

MY_P="${P/ibus-}"
DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://code.google.com/p/ibus-sunpinyin/"
SRC_URI="http://ibus-sunpinyin.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug nls"

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	dev-db/sqlite:3
	>=app-i18n/ibus-1.1
	>=dev-lang/python-2.5
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P%.*}"

src_prepare() {
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable nls) \
		--enable-ibus || die
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}/setup
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}/setup
}
