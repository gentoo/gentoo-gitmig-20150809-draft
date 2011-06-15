# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libchamplain/libchamplain-0.8.2.ebuild,v 1.3 2011/06/15 08:43:37 jlec Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Clutter based world map renderer"
HOMEPAGE="http://blog.pierlux.com/projects/libchamplain/en/"

LICENSE="LGPL-2"
SLOT="0.8"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc gtk +introspection"

RDEPEND="
	dev-libs/glib:2
	>=x11-libs/cairo-1.4
	net-libs/libsoup-gnome:2.4
	media-libs/clutter:1.0[introspection?]
	media-libs/memphis:0.2[introspection?]
	dev-db/sqlite:3
	gtk? (
		x11-libs/gtk+:2[introspection?]
		media-libs/memphis:0.2[introspection?]
		>=media-libs/clutter-gtk-0.10:0.10 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.9 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.3 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF}
		--disable-static
		--enable-memphis
		$(use_enable debug)
		$(use_enable gtk)
		$(use_enable introspection)"
}
