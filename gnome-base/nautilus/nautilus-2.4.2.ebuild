# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-2.4.2.ebuild,v 1.11 2004/05/14 04:22:56 geoman Exp $

inherit gnome2 eutils

DESCRIPTION="A filemanager for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/projects/nautilus/"
SLOT="0"
LICENSE="GPL-2 LGPL-2 FDL-1.1"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64 mips"
IUSE="oggvorbis cups gstreamer"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/pango-1.2
	>=x11-libs/gtk+-2.2
	>=gnome-base/eel-${PV}
	>=dev-libs/libxml2-2.4.7
	>=gnome-base/gnome-vfs-2.3.5
	>=media-sound/esound-0.2.27
	>=gnome-base/gconf-2.3
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.3.3
	>=gnome-base/gnome-desktop-2.2
	>=media-libs/libart_lgpl-2.3.10
	>=gnome-base/libbonobo-2.2
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/librsvg-2.0.1
	>=gnome-base/ORBit2-2.4
	>=x11-libs/startup-notification-0.5
	dev-libs/popt
	app-admin/fam
	sys-apps/eject
	!gstreamer? ( oggvorbis? ( media-sound/vorbis-tools ) )
	cups? ( net-print/libgnomecups
		net-print/gnome-cups-manager )
	gstreamer? ( >=media-libs/gstreamer-0.6*
		=media-libs/gst-plugins-0.6* )"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29
	>=sys-devel/autoconf-2.58"

PDEPEND="x11-themes/gnome-icon-theme
	x11-themes/gnome-themes"

DOCS="AUTHORS COPYIN* ChangeLo* HACKING INSTALL MAINTAINERS NEWS README THANKS TODO"

G2CONF="${G2CONF} $(use_enable gstreamer)"

src_unpack() {

	unpack ${A}

	cd ${S}
	# Fix a cdda linking error. (it silently links to cdda)
	epatch ${FILESDIR}/${PN}-2-disable-cdda.patch

	# Fix compile vs gtk-2.4
	epatch ${FILESDIR}/${PN}-2.4-remove_deprecation_flags.patch

	# use gstreamer for audio preview (patch by <foser@gentoo.org>)
	use gstreamer && epatch ${FILESDIR}/${PN}-2-icon_view_gst_audio_preview.patch
	# add libgnomeprint support
	use cups && epatch ${FILESDIR}/${PN}-2-x-printers.patch
	WANT_AUTOCONF=2.5 autoheader || die
	WANT_AUTOCONF=2.5 autoconf || die
	WANT_AUTOMAKE=1.4 automake || die
}
