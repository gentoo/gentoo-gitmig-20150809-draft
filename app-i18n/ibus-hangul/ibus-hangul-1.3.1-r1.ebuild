# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-hangul/ibus-hangul-1.3.1-r1.ebuild,v 1.1 2011/05/25 00:04:59 matsuu Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
inherit eutils python

DESCRIPTION="The Hangul engine for IBus input platform"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=app-i18n/ibus-1.2.99
	>=app-i18n/libhangul-0.0.12
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( >=sys-devel/gettext-0.17 )"

src_prepare() {
	# http://pkgs.fedoraproject.org/gitweb/?p=ibus-hangul.git
	epatch "${FILESDIR}/${PN}-ibus-1.4.patch" || die
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf $(use_enable nls) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README || die
}
