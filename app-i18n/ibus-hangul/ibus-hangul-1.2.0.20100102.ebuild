# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-hangul/ibus-hangul-1.2.0.20100102.ebuild,v 1.6 2011/05/25 00:04:59 matsuu Exp $

PYTHON_DEPEND="2:2.5"
inherit python

DESCRIPTION="The Hangul engine for IBus input platform"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND=">=dev-lang/python-2.5
	>=app-i18n/ibus-1.2
	!>=app-i18n/ibus-1.3.99
	>=app-i18n/libhangul-0.0.10
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( >=sys-devel/gettext-0.17 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}
