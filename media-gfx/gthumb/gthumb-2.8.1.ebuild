# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-2.8.1.ebuild,v 1.6 2007/03/23 12:13:57 corsair Exp $

WANT_AUTOCONF="2.5"
WANT_AUTOMAKE="1.8"

inherit eutils autotools gnome2

DESCRIPTION="Image viewer and browser for Gnome"
HOMEPAGE="http://gthumb.sourceforge.net/"
LICENSE="GPL-2"

IUSE="exif gphoto2 jpeg tiff"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ppc64 x86"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.8
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
	exif? ( >=media-libs/libexif-0.6.9 )
	gphoto2? ( >=media-libs/libgphoto2-2.1.3 )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	app-text/scrollkeeper
	>=dev-util/intltool-0.29"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

pkg_setup() {
	G2CONF="$(use_enable exif) \
		$(use_enable gphoto2) \
		$(use_enable jpeg) \
		$(use_enable tiff)"
}

src_unpack() {
	gnome2_src_unpack

	# as-needed #130284
	# New as-needed, including gphoto fixes
	epatch "${FILESDIR}/${PN}-2.8.1-as-needed.patch"

	# Respect zoom preferences.  Bug #156342
	epatch "${FILESDIR}/${PN}-2.8.1-respect-zoom-pref.patch"

	# Fix compilation if USE=-exif (bug #163533)
	epatch "${FILESDIR}/${P}-noexif_fixes.patch"

	eautoreconf
}
