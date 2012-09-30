# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpeas/libpeas-1.4.0-r1.ebuild,v 1.3 2012/09/30 07:36:54 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="python? 2:2.5"

inherit eutils gnome2 multilib python virtualx

DESCRIPTION="A GObject plugins library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2+"
SLOT="0"
IUSE="doc gjs +gtk glade +python seed vala"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"

RDEPEND=">=dev-libs/glib-2.31.2:2
	>=dev-libs/gobject-introspection-0.10.1
	gjs? ( >=dev-libs/gjs-1.31.11 )
	glade? ( >=dev-util/glade-3.9.1:3.10 )
	gtk? ( >=x11-libs/gtk+-2.91.1:3[introspection] )
	python? ( >=dev-python/pygobject-3.0.0:3 )
	seed? ( >=dev-libs/seed-2.91.91 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	doc? ( >=dev-util/gtk-doc-1.11 )
	vala? ( >=dev-lang/vala-0.11.1:0.12 )"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable gjs)
		$(use_enable glade glade-catalog)
		$(use_enable gtk)
		$(use_enable python)
		$(use_enable seed)
		$(use_enable vala)
		VALAC=$(type -P valac-0.12)
		--disable-deprecation
		--disable-static"
	# Wtf, --disable-gcov, --enable-gcov=no, --enable-gcov, all enable gcov
	# What do we do about gdb, valgrind, gcov, etc?

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# In next release, bug #415961
	epatch "${FILESDIR}/${P}-pkgconfig.patch"

	use python && python_clean_py-compile_files
	gnome2_src_prepare
}

src_test() {
	# FIXME: Tests fail because of some bug involving Xvfb and Gtk.IconTheme
	# DO NOT REPORT UPSTREAM, this is not a libpeas bug.
	# To reproduce:
	# >>> from gi.repository import Gtk
	# >>> Gtk.IconTheme.get_default().has_icon("gtk-about")
	# This should return True, it returns False for Xvfb
	Xemake check
}

pkg_postinst() {
	gnome2_pkg_postinst
	use python && python_mod_optimize /usr/$(get_libdir)/peas-demo
}

pkg_postrm() {
	gnome2_pkg_postrm
	use python && python_mod_cleanup /usr/$(get_libdir)/peas-demo
}
