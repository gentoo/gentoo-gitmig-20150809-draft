# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-panel/gnome-panel-2.0.10.ebuild,v 1.1 2002/10/14 15:24:59 foser Exp $

IUSE="doc"

MAKEOPTS="-j1"
inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="The Panel for Gnome2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2 FDL-1.1 LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"

RDEPEND=">=x11-libs/gtk+-2.0.3
	>=dev-libs/libxml2-2.4.24
	>=dev-libs/glib-2.0.6-r1
	>=x11-libs/libwnck-0.13
	>=app-text/scrollkeeper-0.3.11
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/bonobo-activation-1.0.3
	>=gnome-base/gconf-1.2.1
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gnome-desktop-2.0.3
	>=gnome-base/libbonobo-2.0.0-r1
	>=gnome-base/libbonoboui-2.0.3
	>=gnome-base/libglade-2.0.0
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomecanvas-2.0.4
	>=gnome-base/libgnomeui-2.0.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS  README*"
