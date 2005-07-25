# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/thoggen/thoggen-0.3.ebuild,v 1.1 2005/07/25 20:57:45 hanno Exp $

inherit gnome2 eutils

DESCRIPTION="DVD ripper, based on GStreamer and Gtk+"
HOMEPAGE="http://thoggen.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="dts"

DEPEND=">=dev-libs/glib-2.6.0
	>=x11-libs/gtk+-2.6.0
	>=gnome-base/libglade-2.4.0
	>=media-libs/gstreamer-0.8.9
	>=media-libs/gst-plugins-0.8.8
	>=media-plugins/gst-plugins-mpeg2dec-0.8.8
	>=media-plugins/gst-plugins-a52dec-0.8.8
	>=media-plugins/gst-plugins-dvdread-0.8.8
	>=media-plugins/gst-plugins-theora-0.8.8
	>=media-plugins/gst-plugins-vorbis-0.8.8
	>=media-plugins/gst-plugins-ogg-0.8.8
	dts? ( >=media-plugins/gst-plugins-dts-0.8.8 )
	>=sys-apps/dbus-0.22
	>=sys-apps/hal-0.4.0
	>=media-libs/libdvdread-0.9.4"

pkg_setup() {
	if ! built_with_use sys-apps/dbus gtk; then
		eerror "Please merge sys-apps/dbus with 'gtk' in USE flags."
		die "Need glib support in dbus!"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${PN}-0.3-new-dbus-hal.patch
}

DOCS="AUTHORS ChangeLog NEWS README TODO"

# needed to get around some sandboxing checks
export GST_INSPECT=/bin/true
