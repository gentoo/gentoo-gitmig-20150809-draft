# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-canna/im-canna-0.3.2.1.ebuild,v 1.2 2004/08/04 09:30:40 dholm Exp $

DESCRIPTION="Japanese Canna input method module for GTK+2"
HOMEPAGE="http://bonobo.gnome.gr.jp/~nakai/immodule/"
SRC_URI="http://bonobo.gnome.gr.jp/~nakai/immodule/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.4
	app-i18n/canna"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
}

pkg_postrm() {
	gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
}
