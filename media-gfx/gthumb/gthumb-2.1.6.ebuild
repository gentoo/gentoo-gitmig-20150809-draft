# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-2.1.6.ebuild,v 1.4 2003/09/12 09:27:59 spider Exp $

inherit gnome2

IUSE="jpeg tiff png"
DESCRIPTION="Image viewer and browser for Gnome"
HOMEPAGE="http://gthumb.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=dev-libs/libxml2-2.4
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-vfs-2.1.3
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gconf-2
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	jpeg? ( media-libs/jpeg
		>=media-libs/libexif-0.5.10 )"

DEPEND=">=dev-util/pkgconfig-0.9.0
	app-text/scrollkeeper
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README"
