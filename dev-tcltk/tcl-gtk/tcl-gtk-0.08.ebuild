# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcl-gtk/tcl-gtk-0.08.ebuild,v 1.4 2004/12/15 10:11:01 mr_bones_ Exp $

DESCRIPTION="GTK bindings for TCL"
HOMEPAGE="http://tcl-gtk.sf.net/"
SRC_URI="mirror://sourceforge/tcl-gtk/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND=">=dev-lang/tcl-8.4
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=x11-libs/vte-0.11.11"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
