# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-1.99.16.ebuild,v 1.10 2004/01/09 14:44:53 agriffis Exp $

# since its a development version
inherit debug gnome.org

DESCRIPTION="GTK+2 bindings for Python"
#SRC_URI="ftp://ftp.gtk.org/pub/gtk/python/v2.0/${P}.tar.gz"
HOMEPAGE="http://www.daa.com.au/~james/pygtk/"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="x86 ppc ~sparc alpha"
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
	einfo 'If you built pygtk with OpenGL support you still need to emerge'
	einfo 'PyOpenGL to actually be able to use it. '
}
