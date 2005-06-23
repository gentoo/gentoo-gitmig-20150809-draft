# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/rep-gtk/rep-gtk-0.15-r3.ebuild,v 1.21 2005/06/23 13:13:18 agriffis Exp $

IUSE="gnome"

DESCRIPTION="GTK/GDK bindings for the librep Lisp environment"
SRC_URI="mirror://sourceforge/rep-gtk/${P}.tar.gz"
HOMEPAGE="http://rep-gtk.sourceforge.net/"

SLOT="1.2"
LICENSE="GPL-2"
KEYWORDS="x86 sparc -ppc alpha"

DEPEND="=x11-libs/gtk+-1.2*
	>=dev-libs/librep-0.13.4
	gnome? ( <gnome-base/libglade-2
		>=media-libs/gdk-pixbuf-0.11.0-r1 )"

RDEPEND="=x11-libs/gtk+-1.2*
	gnome? ( <gnome-base/libglade-2
		>=media-libs/gdk-pixbuf-0.11.0-r1 )"

src_compile() {
	local myconf=""

	if use gnome
	then
		myconf="--with-gnome --with-libglade"
	else
		myconf="--without-gnome \
			--without-libglade \
			--without-gdk-pixbuf \
			--without-gnome-canvas-pixbuf"
	fi

	econf ${myconf} || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS COPYING ChangeLog README* TODO
	docinto examples
	dodoc examples/*
}
