# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator/avant-window-navigator-0.3.2.1.ebuild,v 1.9 2011/04/25 20:43:46 arfrever Exp $

EAPI=3
PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml"

inherit gnome2 python

DESCRIPTION="Fully customisable dock-like window navigator."
HOMEPAGE="http://launchpad.net/awn"
SRC_URI="http://launchpad.net/awn/0.2/${PV}/+download/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~x86"
# upstream asked for gconf to be forced until optional support is fixed
IUSE="doc gnome thunar vala"

RDEPEND="
	dev-libs/dbus-glib
	>=dev-libs/glib-2.16.0
	dev-python/pycairo
	>=dev-python/pygtk-2:2
	dev-python/pyxdg
	>=gnome-base/gconf-2:2
	>=gnome-base/libglade-2:2.0
	>=x11-libs/gtk+-2:2
	>=x11-libs/libwnck-2.20:1
	gnome? (
		>=gnome-base/gnome-desktop-2:2
		>=gnome-base/gnome-vfs-2:2
		>=gnome-base/libgnome-2
	)
	thunar? ( xfce-extra/thunar-vfs )
	vala? ( dev-lang/vala:0.10 )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.4 )
"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare

	# Disable pyc compiling.
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

src_configure() {
	local myconf

	if use gnome; then myconf="--with-desktop=gnome"
	elif use thunar; then myconf="--with-desktop=xfce4"
	else myconf="--with-desktop=agnostic"
	fi

	econf $(use_enable doc gtk-doc) \
		$(use_with vala) \
		--with-gconf \
		--disable-static \
		--disable-pymod-checks \
		VALAC=$(type -P valac-0.10) \
		VALA_GEN_INTROSPECT=$(type -O vapigen-0.10) \
		${myconf}
}

pkg_postinst() {
	gnome2_pkg_postinst

	ewarn
	ewarn "AWN will be of no use if you do not have a compositing manager."

	python_mod_optimize awn
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup awn
}
