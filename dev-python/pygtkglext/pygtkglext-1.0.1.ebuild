# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtkglext/pygtkglext-1.0.1.ebuild,v 1.3 2004/02/14 12:45:22 liquidx Exp $

inherit python

DESCRIPTION="Python bindings to GtkGLExt"
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.2.3-r3
	>=dev-python/pygtk-2
	>=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.0
	>=x11-libs/gtkglext-1.0.0
	dev-python/PyOpenGL
	virtual/x11
	virtual/opengl
	virtual/glu"

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README COPYING* AUTHORS ChangeLog
	insinto /usr/share/doc/${PF}/examples
	doins examples/*.py
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/gtk-2.0
}

pkg_postrm() {
	python_mod_cleanup
}
