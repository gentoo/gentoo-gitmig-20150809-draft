# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-2.1.4.ebuild,v 1.3 2003/09/06 23:56:39 msterret Exp $

inherit gnome2

IUSE="jpeg"
DESCRIPTION="Image viewer and browser for Gnome"
HOMEPAGE="http://gthumb.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=dev-libs/libxml2-2.4
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-vfs-2.1.3
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeprint-2.1
	>=gnome-base/libgnomeprintui-2.1
	>=gnome-base/bonobo-activation-1
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	jpeg ( media-libs/jpeg
		>=media-libs/libexif-0.5.8 )"

DEPEND=">=dev-util/pkgconfig-0.9.0
	app-text/scrollkeeper
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"
