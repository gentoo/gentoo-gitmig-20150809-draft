# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gucharmap/gucharmap-0.8.0.ebuild,v 1.1 2003/08/20 15:19:36 utx Exp $

inherit gnome2

IUSE=""
DESCRIPTION="A featureful Unicode character map."
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86"

RDEPEND=">=gnome-base/libgnomeui-2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.22
	dev-util/pkgconfig"

src_install() {
	sed -i -e '/\$(GTK_QUERY_IMMODULES)/d' gucharmap/Makefile

	make DESTDIR=${D} \
		install || die
 
	dodoc COPYING COPYING.LIB ChangeLog INSTALL README TODO
}
 
# DOCS="COPYING COPYING.LIB ChangeLog INSTALL README TODO"

pkg_postinst() {
    gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules
}

pkg_postrm() {
    gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules
}
