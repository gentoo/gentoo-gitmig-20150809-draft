# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtkglext/pygtkglext-1.0.1.ebuild,v 1.1 2003/12/06 13:43:16 foser Exp $

DESCRIPTION="Python bindings to GtkGLExt"
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"
LICENSE="LGPL-2.1 GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2
	>=dev-python/pygtk-2
	>=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.0
	>=x11-libs/gtkglext-1.0.0
	dev-python/PyOpenGL
	virtual/x11
	virtual/opengl
	virtual/glu"

src_compile() {

	# ugly hack for sandbox (opens file readwrite, but only really reads)
	addwrite /usr/share/pygtk/2.0/codegen

	econf
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die
	dodoc README COPYING* AUTHORS ChangeLog
	insinto /usr/share/doc/${PF}/examples
	doins examples/*.py

}
