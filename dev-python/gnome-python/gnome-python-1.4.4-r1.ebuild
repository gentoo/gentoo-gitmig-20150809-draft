# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python/gnome-python-1.4.4-r1.ebuild,v 1.6 2005/03/23 14:27:19 liquidx Exp $

inherit gnome.org python

DESCRIPTION="GNOME1 Python Bindings"
HOMEPAGE="http://www.pygtk.org/"

IUSE=""
SLOT="1"
KEYWORDS="x86 ppc ~sparc ~alpha"
LICENSE="GPL-2"

DEPEND="virtual/python
	=x11-libs/gtk+-1.2*
	=dev-python/pygtk-0.6*
	>=media-libs/imlib-1.9.10-r1
	>=gnome-base/gnome-libs-1.4.1.2-r1
	<gnome-base/libglade-1.90.0
	<gnome-base/control-center-1.90.0"

src_unpack() {
	unpack ${A}
	# disable pyc compiling
	mv ${S}/py-compile ${S}/py-compile.orig
	ln -s /bin/true ${S}/py-compile
}

src_compile() {
	CFLAGS="${CFLAGS} `gnome-config capplet --cflags`" \
		econf || die "econf failed"

	cd ${S}/pygnome
	emake || die
}

src_install() {
	dodoc AUTHORS COPYING* ChangeLog NEWS MAPPING
	dodoc README*
	cd ${S}/pygnome
	make prefix=${D}/usr datadir=${D}/usr/share install || die " install failed"
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/gtk-1.2/gnome
}

pkg_postrm() {
	python_mod_cleanup
}
