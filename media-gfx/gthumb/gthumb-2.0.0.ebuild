# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-2.0.0.ebuild,v 1.1 2003/01/21 00:48:12 foser Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Image viewer and browser for Gnome"
HOMEPAGE="http://gthumb.sourceforge.net/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.4
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libglade-2
	=gnome-base/libgnomeprint-1*
	=gnome-base/libgnomeprintui-1*
	>=gnome-base/bonobo-activation-1
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2"

DEPEND=">=dev-util/pkgconfig-0.9.0
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"
