# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lablgtk/lablgtk-2.2.0.ebuild,v 1.1 2004/01/22 22:27:38 mattam Exp $

IUSE="gnome opengl debug glade svg"

DESCRIPTION="Objective CAML interface for Gtk+2"
HOMEPAGE="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/lablgtk.html"
SRC_URI="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/dist/${P}.tar.gz"
LICENSE="LGPL-2.1 as-is"

DEPEND="=x11-libs/gtk+-2.2*
	>=dev-lang/ocaml-3.07
	svg? ( >=gnome-base/librsvg-2.2* )
	glade? ( >=gnome-base/libglade-2.0.1 )
	gnome? ( >=gnome-base/libgnomecanvas-2.2
		>=gnome-base/gnome-panel-2.4.0
		>=gnome-base/libgnomeui-2.4.0
		media-libs/gdk-pixbuf )
	opengl? ( >=dev-ml/lablgl-0.98
		>=x11-libs/gtkglarea-1.9* )"

SLOT="2"
KEYWORDS="~x86 ~ppc"

src_compile() {
	use gnome || myconf="$myconf
				--without-gnomecanvas --without-gnomeui
				--without-panel"
	use opengl || myconf="$myconf --without-gl"
	use svg || myconf="$myconf --without-rsvg"
	use glade || myconf="$myconf --without-glade"
	use debug && myconf="$myconf --enable-debug"

	econf $myconf || die "configure failed"
	make all opt || die "make failed"
}

install_examples() {
	examples=/usr/share/doc/${P}/examples
	dodir $examples
	insinto $examples
	doins examples/*.ml examples/*.rgb
}

src_install () {
	make install DESTDIR=${D} || die
	dodoc CHANGES COPYING README
	use doc && install_examples
}

pkg_postinst () {
	use doc && einfo "To run the examples you can use the lablgtk2 toplevel."
	use doc && einfo "e.g: lablgtk2 /usr/share/doc/${P}/examples/testgtk.ml"
}
