# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/clutter-gst/clutter-gst-1.0.0.ebuild,v 1.2 2010/06/26 01:54:10 nirbheek Exp $

EAPI="2"

# inherit clutter after gnome2 so that defaults aren't overriden
inherit gnome2 clutter

DESCRIPTION="GStreamer Integration library for Clutter"

SLOT="1.0"
KEYWORDS="~amd64 ~x86"
# XXX: USE=introspection is package.use.mask-ed in base profile
# till gstreamer and gst-plugins-base get introspection support
# XXX: Make introspection -> +introspection after unmasking it
IUSE="debug doc examples introspection"

RDEPEND="
	>=dev-libs/glib-2.20
	media-libs/clutter:1.0[introspection?]
	media-libs/gstreamer:0.10[introspection?]
	media-libs/gst-plugins-base:0.10[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.6.8 )"
DEPEND="${RDEPEND}
	virtual/python"

DOCS="AUTHORS ChangeLog NEWS README"
EXAMPLES="examples/{*.c,*.png,README}"

pkg_setup() {
	# XXX: debug default is "minimum" in even releases; "yes" in odd releases
	G2CONF="${G2CONF}
		$(use_enable introspection)"
}
