# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-1.99.13-r1.ebuild,v 1.18 2004/07/20 20:03:37 kloeri Exp $

# since its a development version
inherit debug

DESCRIPTION="GTK+2 bindings for Python"
HOMEPAGE="http://www.pygtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/python/v2.0/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="x86 ~ppc sparc alpha ia64"
IUSE="opengl"

DEPEND=">=dev-lang/python-2.2
	>=x11-libs/pango-1.0.0
	>=gnome-base/libglade-2.0.0
	opengl? ( >=x11-libs/gtkglarea-1.99.0 )"

src_compile() {
	./configure --prefix=/usr/ \
		--enable-thread \
		--host=${CHOST} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL MAPPING NEWS README THREADS TODO
}

pkg_postinst() {
	einfo 'If you built pygtk with OpenGL support you still need to emerge'
	einfo 'pyopengl to actually be able to use it. '
}
