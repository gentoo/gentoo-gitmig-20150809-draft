# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python/gnome-python-2.0.0-r1.ebuild,v 1.4 2004/04/01 19:55:41 gustavoz Exp $

inherit gnome2 python

DESCRIPTION="GNOME 2 bindings for Python"
HOMEPAGE="http://www.daa.com.au/~james/pygtk/"

IUSE="gtkhtml"
LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="x86 ~ppc ~alpha sparc ~amd64"

RDEPEND=">=dev-lang/python-2.2
	>=dev-python/pygtk-${PV}*
	>=dev-python/pyorbit-2.0
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gconf-1.2
	>=x11-libs/libzvt-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/nautilus-2
	>=gnome-base/gnome-panel-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	gtkhtml? ( =gnome-extra/libgtkhtml-2* )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

src_unpack() {
	unpack ${A}
	# disable pyc compiling
	mv ${S}/py-compile ${S}/py-compile.orig
	ln -s /bin/true ${S}/py-compile
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/gtk-2.0
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}

