# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/rep-gtk/rep-gtk-0.18-r3.ebuild,v 1.10 2008/05/17 14:11:56 truedfx Exp $

inherit eutils toolchain-funcs multilib

DESCRIPTION="A GTK+/libglade/GNOME language binding for the librep Lisp environment"
HOMEPAGE="http://rep-gtk.sourceforge.net/"
SRC_URI="mirror://sourceforge/rep-gtk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="gtk-2.0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE="gnome"

RDEPEND=">=dev-libs/librep-0.13
	>=gnome-base/libglade-2.0.0
	>=x11-libs/gtk+-2.0.3
	gnome? ( >=gnome-base/libbonobo-2.0.0
		>=gnome-base/libbonoboui-2.0.0
		>=gnome-base/libgnome-2.0.0
		>=gnome-base/libgnomeui-2.0.0
		>=gnome-base/libgnomecanvas-2.0.0 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix for bug 45646 to sync up rep-gtk headers with gtk+
	if has_version '>=x11-libs/gtk+-2.4'; then
		epatch "${FILESDIR}/rep-gtk-0.18-gtk24.patch"
	fi

	# Remove reference to gtk internal functions.  These functions are no
	# longer available in recent versions of gtk, and sawfish doesn't use
	# them anyway.  Bug 48439
	epatch "${FILESDIR}/rep-gtk-0.18-gtk26.patch"

	epatch "${FILESDIR}/libtool.patch"
}

src_compile() {
	econf \
		--libdir=/usr/$(get_libdir) \
		--with-libglade \
		--with-gdk-pixbuf \
		$(use_with gnome) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog HACKING README* TODO
}
