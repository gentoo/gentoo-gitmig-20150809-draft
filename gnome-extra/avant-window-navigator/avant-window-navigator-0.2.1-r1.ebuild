# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator/avant-window-navigator-0.2.1-r1.ebuild,v 1.3 2008/02/18 00:39:42 mr_bones_ Exp $

inherit gnome2 python

DESCRIPTION="Fully customisable dock-like window navigator for GNOME."
HOMEPAGE="http://launchpad.net/awn"
SRC_URI="http://launchpad.net/awn/${PV%.*}/${PV}/+download/${P}.tar"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/glib-2.8
	dev-python/gnome-python-desktop
	gnome-extra/gconf-editor
	x11-libs/libwnck"
RDEPEND="${DEPEND}"

src_unpack() {
	gnome2_src_unpack

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize	/usr/$(get_libdir)/python${PYVER}/site-packages/awn
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python${PYVER}/site-packages/awn
}
