# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-2.0.0-r1.ebuild,v 1.1 2004/01/24 16:56:05 liquidx Exp $

inherit gnome.org python

DESCRIPTION="GTK+2 bindings for Python"
HOMEPAGE="http://www.daa.com.au/~james/pygtk/"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~x86 ppc ~sparc ~alpha"
IUSE="gnome opengl"

RDEPEND=">=dev-lang/python-2.2
	>=x11-libs/pango-1
	>=x11-libs/gtk+-2
	>=dev-libs/atk-1
	>=dev-libs/glib-2
	gnome? ( >=gnome-base/libglade-2 )
	opengl? ( virtual/opengl
		dev-python/PyOpenGL
		>=x11-libs/gtkglarea-1.99 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_unpack() {
	unpack ${A}
	# disable pyc compiling
	mv ${S}/py-compile ${S}/py-compile.orig
	ln -s /bin/true ${S}/py-compile
}

src_compile() {
	econf --enable-thread || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL MAPPING NEWS README THREADS TODO

	python_version
	mv ${D}/usr/lib/python${PYVER}/site-packages/pygtk.py \
		${D}/usr/lib/python${PYVER}/site-packages/pygtk.py-2.0
	mv ${D}/usr/lib/python${PYVER}/site-packages/pygtk.pth \
		${D}/usr/lib/python${PYVER}/site-packages/pygtk.pth-2.0
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/share/pygtk/2.0/codegen /usr/lib/python${PYVER}/site-packages/gtk-2.0
	alternatives_auto_makesym /usr/lib/python${PYVER}/site-packages/pygtk.py pygtk.py-[0-9].[0-9]
	alternatives_auto_makesym /usr/lib/python${PYVER}/site-packages/pygtk.pth pygtk.pth-[0-9].[0-9]
	python_mod_compile /usr/lib/python${PYVER}/site-packages/pygtk.py
}

pkg_postrm() {
	python_version
	python_mod_cleanup /usr/share/pygtk/2.0/codegen
	python_mod_cleanup
	rm -f ${ROOT}/usr/lib/python${PYVER}/site-packages/pygtk.{py,pth}
	alternatives_auto_makesym /usr/lib/python${PYVER}/site-packages/pygtk.py pygtk.py-[0-9].[0-9]
	alternatives_auto_makesym /usr/lib/python${PYVER}/site-packages/pygtk.pth pygtk.pth-[0-9].[0-9]
}
