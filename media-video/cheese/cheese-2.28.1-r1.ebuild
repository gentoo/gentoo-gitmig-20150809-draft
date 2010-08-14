# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cheese/cheese-2.28.1-r1.ebuild,v 1.9 2010/08/14 19:04:00 armin76 Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2 eutils

DESCRIPTION="A cheesy program to take pictures and videos from your webcam"
HOMEPAGE="http://www.gnome.org/projects/cheese/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc x86"
IUSE="v4l"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.7
	>=dev-libs/glib-2.16.0
	>=x11-libs/gtk+-2.18
	>=x11-libs/cairo-1.4.0
	>=x11-libs/pango-1.18.0
	>=sys-apps/dbus-1[X]
	>=sys-apps/hal-0.5.9
	>=gnome-base/gconf-2.16.0
	>=gnome-base/gnome-desktop-2.26
	>=gnome-base/librsvg-2.18.0
	>=gnome-extra/evolution-data-server-1.12

	>=media-libs/gstreamer-0.10.16
	>=media-libs/gst-plugins-base-0.10.16"
RDEPEND="${COMMON_DEPEND}
	>=media-plugins/gst-plugins-gconf-0.10
	>=media-plugins/gst-plugins-ogg-0.10.16
	>=media-plugins/gst-plugins-pango-0.10.16
	>=media-plugins/gst-plugins-theora-0.10.16
	>=media-plugins/gst-plugins-v4l2-0.10
	>=media-plugins/gst-plugins-vorbis-0.10.16
	>=media-libs/gst-plugins-good-0.10.16
	v4l? ( >=media-plugins/gst-plugins-v4l-0.10 )
	|| ( >=media-plugins/gst-plugins-x-0.10
		>=media-plugins/gst-plugins-xvideo-0.10 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	app-text/scrollkeeper
	app-text/gnome-doc-utils
	x11-proto/xf86vidmodeproto
	app-text/docbook-xml-dtd:4.3"

DOCS="AUTHORS ChangeLog NEWS README"
