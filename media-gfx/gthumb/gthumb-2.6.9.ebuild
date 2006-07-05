# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-2.6.9.ebuild,v 1.2 2006/07/05 22:39:55 dang Exp $

inherit gnome2 eutils autotools

DESCRIPTION="Image viewer and browser for Gnome"
HOMEPAGE="http://gthumb.sourceforge.net/"
LICENSE="GPL-2"

IUSE="exif jpeg tiff png gphoto2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"

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
	exif? ( >=media-libs/libexif-0.5.12 )
	gphoto2? ( >=media-libs/libgphoto2-2.1.3 )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	app-text/scrollkeeper
	>=dev-util/intltool-0.29"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable exif) $(use_enable gphoto2) \
			$(use_enable jpeg) $(use_enable png) $(use_enable tiff)"
}

src_unpack() {
	gnome2_src_unpack

	# fix for bug #112129, backported from CVS upstream
	epatch "${FILESDIR}"/${PN}-2.6.8-Makefile.patch

	# Add configure options (Bug #103365), patch merged upstream
	epatch "${FILESDIR}"/${PN}-2.6.8-options.patch

	# as-needed #130284
	# New as-needed, including gphoto fixes
	epatch "${FILESDIR}"/${PN}-2.6.9-as-needed.patch

	eautoreconf
}
