# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python/gnome-python-1.99.16.ebuild,v 1.4 2003/06/22 12:15:59 liquidx Exp $

# devel version - debug
inherit gnome2 debug

IUSE="gtkhtml"

DESCRIPTION="GNOME 2 bindings for Python"
HOMEPAGE="http://www.daa.com.au/~james/pygtk/"
LICENSE="LGPL-2"

DEPEND=">=dev-lang/python-2.2
	>=dev-python/pygtk-${PV}*
	>=dev-python/pyorbit-1.99.4
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gconf-1.2
	>=x11-libs/libzvt-2
	>=gnome-base/bonobo-activation-1
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/nautilus-2
	>=gnome-base/gnome-panel-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	gtkhtml? ( =gnome-extra/libgtkhtml-2* )"

RDEPEND="${DEPEND} 
	>=dev-util/pkgconfig-0.12.0"

SLOT="2"
KEYWORDS="~x86 ~ppc"

# ugly, but necessary
addwrite /usr/share/pygtk/2.0/codegen

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
