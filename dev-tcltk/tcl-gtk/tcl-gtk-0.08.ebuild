# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcl-gtk/tcl-gtk-0.08.ebuild,v 1.1 2004/08/25 06:27:35 cardoe Exp $

IUSE=""
DESCRIPTION="GTK bindings for TCL"
HOMEPAGE="http://tcl-gtk.sf.net/"
SRC_URI="mirror://sourceforge/tcl-gtk/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND=">=dev-lang/tcl-8.4
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2"

src_compile() {
	econf || die "./configure failed"
	make || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
}
