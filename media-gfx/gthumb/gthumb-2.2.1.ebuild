# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-2.2.1.ebuild,v 1.1 2004/01/26 23:45:30 foser Exp $

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
	>=gnome-base/libbonobo-2.3.3
	>=gnome-base/libbonoboui-2.3.3
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	jpeg? ( media-libs/jpeg
		>=media-libs/libexif-0.5.12 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	app-text/scrollkeeper
	>=dev-util/intltool-0.21"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

MAKEOPTS="${MAKEOPTS} -j2"

pkg_postinst() {

	gnome2_pkg_postinst

	einfo "Due to a mistake in slotting this package it may be that gthumb-2.0.1"
	einfo "is shown to be installed alongside this release."
	einfo "To fix this issue 'emerge -C =gthumb-2.0*' as root, this should"
	einfo "have no influence on your current installed gthumb."

}
