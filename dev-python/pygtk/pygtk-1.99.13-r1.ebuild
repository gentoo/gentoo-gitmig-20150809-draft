# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-1.99.13-r1.ebuild,v 1.6 2003/06/12 20:38:48 msterret Exp $

# since its a development version
inherit debug 

S=${WORKDIR}/${P}
DESCRIPTION="GTK+2  bindings for Python"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/python/v2.0/${P}.tar.gz"
HOMEPAGE="http://www.daa.com.au/~james/pygtk/"
LICENSE="LGPL-2.1"

KEYWORDS="x86 ~ppc sparc alpha"


DEPEND=">=dev-lang/python-2.2
	>=x11-libs/pango-1.0.0
	>=gnome-base/libglade-2.0.0
	opengl? ( >=x11-libs/gtkglarea-1.99.0 )"

SLOT="2.0"

src_compile() {

	./configure --prefix=/usr/ \
		--enable-thread \
	            --host=${CHOST} || die
	emake || die
}

src_install () {
	make prefix=${D}/usr install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL MAPPING NEWS README THREADS TODO
}

pkg_postinst() {
	einfo 'If you built pygtk with OpenGL support you still need to emerge'
	einfo 'PyOpenGL to actually be able to use it. '
}
