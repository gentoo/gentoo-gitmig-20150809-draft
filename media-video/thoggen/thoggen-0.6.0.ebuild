# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/thoggen/thoggen-0.6.0.ebuild,v 1.1 2006/10/19 20:24:34 hanno Exp $

inherit gnome2

DESCRIPTION="DVD ripper, based on GStreamer and Gtk+"
HOMEPAGE="http://thoggen.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=gnome-base/libglade-2.4.0
	>=media-libs/gst-plugins-base-0.10.10
	>=media-libs/gst-plugins-good-0.10.4
	>=media-libs/gst-plugins-ugly-0.10.4
	>=media-plugins/gst-plugins-mpeg2dec-0.10.4
	>=media-plugins/gst-plugins-a52dec-0.10.4
	>=media-plugins/gst-plugins-dvdread-0.10.4
	>=media-plugins/gst-plugins-theora-0.10.10
	>=media-plugins/gst-plugins-vorbis-0.10.10
	>=media-plugins/gst-plugins-ogg-0.10.10
	>=sys-apps/hal-0.4
	>=media-libs/libdvdread-0.9.4"

pkg_setup() {
	if ! built_with_use sys-apps/dbus gtk; then
		eerror "Please merge sys-apps/dbus with 'gtk' in USE flags."
		die "Need glib support in dbus!"
	fi
}

G2CONF="--disable-element-checks"
DOCS="AUTHORS ChangeLog NEWS README TODO"
