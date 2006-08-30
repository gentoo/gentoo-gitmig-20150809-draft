# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lablgtk/lablgtk-2.6.0.ebuild,v 1.7 2006/08/30 12:00:46 dertobi123 Exp $

inherit eutils

IUSE="debug doc glade gnome gnomecanvas opengl svg"

DESCRIPTION="Objective CAML interface for Gtk+2"
HOMEPAGE="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/lablgtk.html"
SRC_URI="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/dist/${P}.tar.gz"
LICENSE="LGPL-2.1 as-is"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-lang/ocaml-3.07
	svg? ( >=gnome-base/librsvg-2.2 )
	glade? ( >=gnome-base/libglade-2.0.1 )
	gnomecanvas? ( >=gnome-base/libgnomecanvas-2.2 )
	gnome? ( >=gnome-base/gnome-panel-2.4.0
		>=gnome-base/libgnomeui-2.4.0 )
	opengl? ( >=dev-ml/lablgl-0.98
		>=x11-libs/gtkglarea-1.9 )"

SLOT="2"
KEYWORDS="~alpha amd64 ~hppa ia64 ppc ~sparc x86"

src_unpack() {
	unpack ${A}
	cd ${S}

	aclocal
	autoreconf
}

src_compile() {
	local myconf

	use debug && myconf="$myconf --enable-debug"

	myconf="$myconf $(use_with svg rsvg)"

	myconf="$myconf $(use_with glade)"

	# libgnomeui already depends on libgnomecanvas
	if use gnomecanvas || use gnome
	then
		myconf="$myconf --with-gnomecanvas"
	else
		myconf="$myconf --without-gnomecanvas"
	fi

	myconf="$myconf $(use_with gnome gnomeui)"
	myconf="$myconf $(use_with gnome panel)"

	myconf="$myconf $(use_with opengl gl)"

	export PKG_CONFIG_PATH=/$(get_libdir)/pkgconfig

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

	# ocamlfind support
	dodir /usr/lib/ocaml/site-packages
	dosym /usr/lib/ocaml/lablgtk2 /usr/lib/ocaml/site-packages/lablgtk2
	insinto /usr/lib/ocaml/lablgtk2
	doins META

	dodoc CHANGES COPYING README
	use doc && install_examples
}

pkg_postinst () {
	use doc && einfo "To run the examples you can use the lablgtk2 toplevel."
	use doc && einfo "e.g: lablgtk2 /usr/share/doc/${P}/examples/testgtk.ml"
}
