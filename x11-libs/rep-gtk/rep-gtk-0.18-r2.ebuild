# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/rep-gtk/rep-gtk-0.18-r2.ebuild,v 1.3 2005/08/21 17:27:19 agriffis Exp $

inherit eutils toolchain-funcs

IUSE="gnome"

DESCRIPTION="A GTK+/libglade/GNOME language binding for the librep Lisp environment"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://rep-gtk.sourceforge.net/"
SLOT="gtk-2.0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~ppc ~sparc x86"

DEPEND="virtual/libc
	>=dev-libs/librep-0.13
	>=dev-util/pkgconfig-0.12.0
	>=gnome-base/libglade-2.0.0
	>=sys-devel/automake-1.6.1-r5
	>=x11-libs/gtk+-2.0.3
	gnome? (
		>=gnome-base/libbonobo-2.0.0
		>=gnome-base/libbonoboui-2.0.0
		>=gnome-base/libgnome-2.0.0
		>=gnome-base/libgnomeui-2.0.0
		>=gnome-base/libgnomecanvas-2.0.0
	)"

src_unpack() {
	unpack ${A}
	cd ${S} || die

	# Fix for bug 45646 to sync up rep-gtk headers with gtk+
	if has_version '>=x11-libs/gtk+-2.4'; then
		epatch ${FILESDIR}/rep-gtk-0.18-gtk24.patch
	fi

	# Remove reference to gtk internal functions.  These functions are no
	# longer available in recent versions of gtk, and sawfish doesn't use
	# them anyway.  Bug 48439, patch from fn_x
	epatch ${FILESDIR}/rep-gtk-0.18-gtk26.patch
}

src_compile() {
	CC=$(tc-getCC) econf \
		--with-libglade \
		--with-gdk-pixbuf \
		$(use_with gnome) || die
	emake host_type=${CHOST} || die
}

src_install() {
	make install \
		host_type=${CHOST} \
		installdir=${D}/usr/lib/rep/${CHOST} || die

	cd ${S}
	dodoc AUTHORS BUGS COPYING ChangeLog HACKING \
		NEWS README* TODO
}

