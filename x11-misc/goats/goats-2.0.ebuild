# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/goats/goats-2.0.ebuild,v 1.5 2003/07/09 16:39:52 liquidx Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Goats is a yellow post-it note applet for the Gnome2 Desktop"
SRC_URI="http://www.menudo.freeserve.co.uk/${P}.tar.gz"
HOMEPAGE="http://www.menudo.freeserve.co.uk/goats.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=x11-libs/pango-1.0.4-r1
	>=x11-libs/gtk+-2.0.6-r1
	>=dev-libs/glib-2.0.6-r1
	>=gnome-base/gconf-1.2.1
	>=gnome-base/gnome-vfs-2.0.2
	>=gnome-base/libglade-2.0.0
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/gnome-panel-2.0.6
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libgnomecanvas-2.0.0
	>=dev-libs/libxml2-2.4.23
	app-text/scrollkeeper"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17
	<gnome-base/libgnomeprintui-2"

DOCS="ABOUT-NLS AUTHORS BUGS ChangeLog COPYING README TODO"
