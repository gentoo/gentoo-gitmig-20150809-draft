# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/imhangul/imhangul-0.9.6.ebuild,v 1.2 2003/04/25 14:03:05 seo Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gtk+-2.0 Hangul Input Modules"
HOMEPAGE="http://imhangul.kldp.net/"
SRC_URI="http://download.kldp.net/imhangul/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=x11-libs/gtk+-2.2.0"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man || die "./configure failed"
	
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}

pkg_postinst() {
    gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules

	einfo ""
	einfo "If you want to use one of the module as a default input method, "
	einfo ""
	einfo "export GTK_IM_MODULE=hangul2		// 2 input type"
	einfo "export GTK_IM_MODULE=hangul3f	// 3 input type"
	einfo ""
}

pkg_postrm() {
    gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules
}
