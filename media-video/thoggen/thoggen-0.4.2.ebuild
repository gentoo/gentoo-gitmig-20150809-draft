# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/thoggen/thoggen-0.4.2.ebuild,v 1.1 2006/04/21 15:04:19 hanno Exp $

inherit gnome2 eutils

DESCRIPTION="DVD ripper, based on GStreamer and Gtk+"
HOMEPAGE="http://thoggen.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dts"

DEPEND=">=dev-libs/glib-2.6.0
	>=x11-libs/gtk+-2.6.0
	>=gnome-base/libglade-2.4.0
	=media-libs/gstreamer-0.8*
	=media-libs/gst-plugins-0.8*
	=media-plugins/gst-plugins-mpeg2dec-0.8*
	=media-plugins/gst-plugins-a52dec-0.8*
	=media-plugins/gst-plugins-dvdread-0.8*
	=media-plugins/gst-plugins-theora-0.8*
	=media-plugins/gst-plugins-vorbis-0.8*
	=media-plugins/gst-plugins-ogg-0.8*
	dts? ( =media-plugins/gst-plugins-dts-0.8* )
	>=sys-apps/dbus-0.23
	>=sys-apps/hal-0.4
	>=media-libs/libdvdread-0.9.4"

pkg_setup() {
	if ! built_with_use sys-apps/dbus gtk; then
		eerror "Please merge sys-apps/dbus with 'gtk' in USE flags."
		die "Need glib support in dbus!"
	fi
}

DOCS="AUTHORS ChangeLog NEWS README TODO"

# needed to get around some sandboxing checks
export GST_INSPECT=/bin/true
