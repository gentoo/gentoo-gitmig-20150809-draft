# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/ochusha/ochusha-0.5.4.3.ebuild,v 1.1 2004/06/06 10:14:04 usata Exp $

IUSE="nls ssl"

DESCRIPTION="Ochusha - 2ch viewer for GTK+"
HOMEPAGE="http://ochusha.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/9791/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/xft
	>=x11-libs/gtk+-2.2.4
	>=dev-libs/glib-2.2.3
	>=dev-libs/libxml2-2.5.0
	>=gnome-base/libghttp-1.0.9
	sys-libs/zlib
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )"

src_compile() {

	econf `use_enable nls` \
		`use_with ssl` \
		--enable-regex \
		--disable-shared \
		--enable-static \
		--with-included-oniguruma || die
	emake || die
}

src_install() {

	einstall || die

	dodoc ABOUT-NLS ACKNOWLEDGEMENT AUTHORS BUGS \
		ChangeLog INSTALL* NEWS README TODO
}
