# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python/gnome-python-1.99.13.ebuild,v 1.2 2003/02/13 11:34:32 vapier Exp $

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="Gnome-2 bindings for Python"
HOMEPAGE="http://www.daa.com.au/~james/pygtk/"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/python-2.2
	>=dev-python/pygtk-1.99.13
	>=dev-python/orbit-python-1.99.0
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-vfs-2
	>=x11-libs/libzvt-2
	>=gnome-base/gconf-1.2
	>=gnome-base/bonobo-activation-1
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/nautilus-2
	>=gnome-base/gnome-panel-2
	>=gnome-extra/libgtkhtml-2"

SLOT="2"
RDEPEND="${DEPEND} >=dev-util/pkgconfig-0.12.0"
KEYWORDS="~x86"

# ugly, but necessary
addwrite /usr/share/pygtk/2.0/codegen

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
