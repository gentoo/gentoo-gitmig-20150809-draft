# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-2.2.0.ebuild,v 1.2 2003/01/31 13:03:26 foser Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="the gnome2 Desktop configuration tool"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

MAKEOPTS="-j1"

RDEPEND=">=x11-libs/gtk+-2.2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gnome-desktop-2
	>=gnome-base/libgnomeui-2
	dev-libs/libxml2
	media-sound/esound
	>=x11-wm/metacity-2.4.5"
																		
DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0" 

DOCS="AUTHORS ChangeLog COPYING README TODO INSTALL NEWS"
