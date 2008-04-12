# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnome-blog/gnome-blog-0.9.1.ebuild,v 1.6 2008/04/12 13:46:39 eva Exp $

inherit gnome2 python

DESCRIPTION="Post entries to your blog right from the Gnome panel"
HOMEPAGE="http://www.gnome.org/~seth/gnome-blog/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2
	>=dev-python/pygtk-2.6
	dev-python/gnome-python"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack () {
	gnome2_src_unpack

	# Let this file be re-created so the path in the <oaf_server> element is
	# correct. See bug #93612.
	rm -f GNOME_BlogApplet.server.in

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/gnomeblog
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python${PYVER}/site-packages/gnomeblog
}
