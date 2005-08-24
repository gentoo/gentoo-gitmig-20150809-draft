# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-2.10.1-r1.ebuild,v 1.9 2005/08/24 01:25:10 vapier Exp $

inherit gnome2 eutils

DESCRIPTION="A filemanager for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/projects/nautilus/"

LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="oggvorbis gstreamer mad flac"
# cups

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/pango-1.2
	>=x11-libs/gtk+-2.3
	>=dev-libs/libxml2-2.4.7
	=gnome-base/eel-${PV}*
	>=gnome-base/gnome-vfs-2.9.1
	>=media-sound/esound-0.2.27
	>=gnome-base/gconf-2
	>=gnome-base/libgnome-2.6
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/gnome-desktop-2.9.91
	>=media-libs/libart_lgpl-2.3.10
	>=gnome-base/libbonobo-2.2
	>=gnome-base/librsvg-2.0.1
	>=gnome-base/orbit-2.4
	>=x11-libs/startup-notification-0.8
	>=media-libs/libexif-0.5.12
	dev-libs/popt
	virtual/fam
	virtual/eject
	!gstreamer? ( oggvorbis? ( media-sound/vorbis-tools ) )
	gstreamer? (
		>=media-libs/gstreamer-0.8
		>=media-libs/gst-plugins-0.8
		>=media-plugins/gst-plugins-gnomevfs-0.8
		mad? ( >=media-plugins/gst-plugins-mad-0.8 )
		oggvorbis? (
			>=media-plugins/gst-plugins-ogg-0.8
			>=media-plugins/gst-plugins-vorbis-0.8
		)
		flac? (	>=media-plugins/gst-plugins-flac-0.8 )
	)"

# FIXME : what to do with exif/jpeg config stuff ?

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.29
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0"

PDEPEND=">=x11-themes/gnome-icon-theme-1.1.91
	x11-themes/gnome-themes"

RESTRICT="test"

DOCS="AUTHORS ChangeLo* HACKING MAINTAINERS NEWS README THANKS TODO"

G2CONF="${G2CONF} $(use_enable gstreamer)"

src_unpack() {

	unpack ${A}
	cd ${S}

	# use gstreamer for audio preview (patch by <foser@gentoo.org>)
	use gstreamer && epatch ${FILESDIR}/${PN}-2.9.90-icon_view_gst.patch

	# Upstream patch to improve font sizes for the icon view.
	# See bug #96721.
	epatch ${FILESDIR}/${P}-font_sizes.patch

	# Upstream patch to fix deselecting items in list view and single click
	# mode. See bug #95606.
	epatch ${FILESDIR}/${P}-deselect.patch

	# -- Component architecture has changed in 2.9 -- libgnomeprint patches
	# no longer apply.

	# stop nautilus linking to cdda/paranoia
	sed -i -e "/^CORE_LIBS/s/\$CDDA_LIBS//" configure.in

	if use gstreamer; then
	WANT_AUTOCONF=2.5 autoheader || die
	WANT_AUTOCONF=2.5 autoconf || die
	WANT_AUTOMAKE=1.7 automake || die
	fi
}

USE_DESTDIR="1"
