# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-0.6.11-r1.ebuild,v 1.1 2004/01/24 16:56:05 liquidx Exp $

inherit python

DESCRIPTION="GTK+ bindings for Python"
HOMEPAGE="http://www.daa.com.au/~james/pygtk/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/python/v1.2/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="virtual/python
	>=gnome-base/libglade-0.17-r6
	>=media-libs/imlib-1.8
	>=media-libs/gdk-pixbuf-0.9.0
	=x11-libs/gtk+-1.2*
	opengl? ( virtual/opengl dev-python/PyOpenGL )"

src_unpack() {
	unpack ${A}
	# disable pyc compiling
	mv ${S}/py-compile ${S}/py-compile.orig
	ln -s /bin/true ${S}/py-compile
}

src_compile() {
	econf
	emake || die "make failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL MAPPING NEWS README TODO

	python_version
	mv ${D}/usr/lib/python${PYVER}/site-packages/pygtk.py \
		${D}/usr/lib/python${PYVER}/site-packages/pygtk.py-1.2
	mv ${D}/usr/lib/python${PYVER}/site-packages/pygtk.pth \
		${D}/usr/lib/python${PYVER}/site-packages/pygtk.pth-1.2
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/share/pygtk/1.2/codegen /usr/lib/python${PYVER}/site-packages/gtk-1.2
	alternatives_auto_makesym /usr/lib/python${PYVER}/site-packages/pygtk.py pygtk.py-[0-9].[0-9]
	alternatives_auto_makesym /usr/lib/python${PYVER}/site-packages/pygtk.pth pygtk.pth-[0-9].[0-9]
	python_mod_compile /usr/lib/python${PYVER}/site-packages/pygtk.py
}

pkg_postrm() {
	python_version
	python_mod_cleanup /usr/share/pygtk/1.2/codegen
	rm -f ${ROOT}/usr/lib/python${PYVER}/site-packages/pygtk.{py,pth}
	alternatives_auto_makesym /usr/lib/python${PYVER}/site-packages/pygtk.py pygtk.py-[0-9].[0-9]
	alternatives_auto_makesym /usr/lib/python${PYVER}/site-packages/pygtk.pth pygtk.pth-[0-9].[0-9]
	python_mod_cleanup
}
