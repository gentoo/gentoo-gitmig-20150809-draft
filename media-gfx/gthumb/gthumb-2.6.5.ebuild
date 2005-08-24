# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-2.6.5.ebuild,v 1.5 2005/08/24 16:56:33 agriffis Exp $

inherit gnome2

DESCRIPTION="Image viewer and browser for Gnome"
HOMEPAGE="http://gthumb.sourceforge.net/"
LICENSE="GPL-2"

IUSE="jpeg tiff png gphoto2"
SLOT="0"
KEYWORDS="~amd64 ia64 ppc x86"

# FIXME : configure switches, no autodetection

RDEPEND=">=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4
	>=dev-libs/libxml2-2.4
	>=gnome-base/libgnome-2.6
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libgnomecanvas-2.6
	>=gnome-base/gnome-vfs-2.6
	>=gnome-base/libglade-2.4
	>=gnome-base/libgnomeprint-2.6
	>=gnome-base/libgnomeprintui-2.6
	>=gnome-base/libbonobo-2.6
	>=gnome-base/libbonoboui-2.6
	>=gnome-base/gconf-2.6
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	jpeg? ( media-libs/jpeg
		>=media-libs/libexif-0.5.12 )
	gphoto2? ( >=media-libs/libgphoto2-2.1.3 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	app-text/scrollkeeper
	>=dev-util/intltool-0.29"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

USE_DESTDIR="1"

src_unpack() {

	unpack ${A}

	# testing for bug #78843
	rm ${S}/components/catalog-view/*.server
	rm ${S}/components/image-viewer/*.server

}

src_install() {

	# workaround #92920 FIXME
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/

}
