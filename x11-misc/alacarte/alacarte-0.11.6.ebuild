# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alacarte/alacarte-0.11.6.ebuild,v 1.3 2009/01/22 14:14:44 fmccor Exp $

inherit gnome2 python eutils

DESCRIPTION="Simple GNOME menu editor"
HOMEPAGE="http://www.realistanew.com/projects/alacarte"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
SLOT=0

common_depends=">=dev-lang/python-2.4
	>=dev-python/pygtk-2.8
	>=gnome-base/gnome-menus-2.18
	>=dev-python/gnome-python-2.18"

RDEPEND="${common_depends}
	>=gnome-base/gnome-panel-2.16"

DEPEND="${common_depends}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	if ! built_with_use gnome-base/gnome-menus python ; then
		eerror "You must emerge gnome-base/gnome-menus with the python USE flag"
		die "alacarte needs python support in gnome-base/gnome-menus"
	fi
}

src_unpack() {
	gnome2_src_unpack

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/Alacarte
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/Alacarte
}
