# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-2.2.0.ebuild,v 1.16 2004/10/17 11:44:38 absinthe Exp $

inherit gnome.org python flag-o-matic

DESCRIPTION="GTK+2 bindings for Python"
HOMEPAGE="http://www.pygtk.org/"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/sources/pygtk/2.2/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="x86 ~ppc sparc alpha hppa amd64 ppc64"
IUSE="gnome opengl"

RDEPEND=">=dev-lang/python-2.2
	>=x11-libs/pango-1
	>=x11-libs/gtk+-2.2
	>=dev-libs/atk-1
	>=dev-libs/glib-2
	gnome? ( >=gnome-base/libglade-2 )
	opengl? ( virtual/opengl
		dev-python/pyopengl
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
	use hppa && append-flags -ffunction-sections
	econf --enable-thread || die
	# possible problems with parallel builds (#45776)
	emake -j1 || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL MAPPING NEWS README THREADS TODO

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
