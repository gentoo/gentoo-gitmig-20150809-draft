# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/ochusha/ochusha-0.5.7.2.ebuild,v 1.3 2005/04/09 13:29:14 corsair Exp $

inherit flag-o-matic

IUSE="nls ssl debug"
use debug && FEATURES="nostrip"

DESCRIPTION="Ochusha - 2ch viewer for GTK+"
HOMEPAGE="http://ochusha.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/12765/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc ppc64"

DEPEND="virtual/xft
	>=x11-libs/gtk+-2.2.4
	>=dev-libs/glib-2.2.3
	>=dev-libs/libxml2-2.5.0
	>=gnome-base/libghttp-1.0.9
	sys-libs/zlib
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )"

src_compile() {

	use debug && append-flags -g

	econf $(use_enable nls) \
		$(use_with ssl) \
		--enable-regex \
		--disable-shared \
		--enable-static \
		--with-included-oniguruma || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc ABOUT-NLS ACKNOWLEDGEMENT AUTHORS BUGS \
		ChangeLog INSTALL* NEWS README TODO
}
