# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-table/ibus-table-1.1.0.20090505.ebuild,v 1.1 2009/05/07 23:47:54 matsuu Exp $

EAPI="2"
inherit eutils python

DESCRIPTION="The Table Engine for IBus Framework"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal nls"

RDEPEND=">=app-i18n/ibus-1.1
	>=dev-lang/python-2.5[sqlite]
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.16.1 )
	dev-util/pkgconfig"

src_prepare() {
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf \
		$(use_enable !minimal additional) \
		$(use_enable nls) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}/engine
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}/engine
}
