# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-ja/im-ja-0.4.ebuild,v 1.2 2003/09/04 14:39:45 usata Exp $

DESCRIPTION="A Japanese input module for GTK2"
HOMEPAGE="http://im-ja.sourceforge.net/"
SRC_URI="${HOMEPAGE}${P}.tar.gz
	${HOMEPAGE}old/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
SLOT=0
IUSE=""

DEPEND="virtual/glibc
	>=dev-libs/glib-2.2.1
	>=dev-libs/atk-1.2.2
	>=x11-libs/gtk+-2.2.1
	>=x11-libs/pango-1.2.1
	>=gnome-base/gconf-2.2
	app-i18n/freewnn
	app-i18n/canna"

src_compile() {

	export CPPFLAGS="${CPPFLAGS} -I/usr/include/wnn -I/usr/include/canna"
	econf || die
	emake || die "make failed"
}

src_install () {

	einstall || die

	dodoc AUTHORS README ChangeLog NEWS TODO
}

pkg_postinst(){

	gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules
}

pkg_postrm(){

	gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules
}
