# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-2.0.0.ebuild,v 1.8 2004/01/09 14:41:40 agriffis Exp $

inherit gnome.org

DESCRIPTION="GTK+2 bindings for Python"
HOMEPAGE="http://www.daa.com.au/~james/pygtk/"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE="gnome opengl"

RDEPEND=">=dev-lang/python-2.2
	>=x11-libs/pango-1
	>=x11-libs/gtk+-2
	>=dev-libs/atk-1
	>=dev-libs/glib-2
	gnome? ( >=gnome-base/libglade-2 )
	opengl? ( >=x11-libs/gtkglarea-1.99 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_compile() {
	econf --enable-thread || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL MAPPING NEWS README THREADS TODO
}

pkg_postinst() {
	einfo 'If you built pygtk with OpenGL support you still need to emerge PyOpenGL to use it. '
}
