# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libchamplain/libchamplain-0.8.1.ebuild,v 1.2 2011/03/02 09:55:58 jlec Exp $

EAPI="3"

inherit gnome2

DESCRIPTION="Clutter based world map renderer"
HOMEPAGE="http://blog.pierlux.com/projects/libchamplain/en/"

LICENSE="LGPL-2"
SLOT="0.8"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc gtk html +introspection"

RDEPEND="
	dev-libs/glib:2
	>=x11-libs/cairo-1.4
	net-libs/libsoup-gnome:2.4
	media-libs/clutter:1.0
	media-libs/memphis
	dev-db/sqlite:3
	gtk? (
		x11-libs/gtk+:2
		media-libs/memphis:0.2
		>=media-libs/clutter-gtk-0.10:0.10 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.9 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.3 )"

DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="${G2CONF}
	--disable-static
	--enable-memphis
	--with-html-dir="${EPREFIX}/usr/share/doc/${PF}/html"
	$(use_enable debug)
	$(use_enable gtk)
	$(use_enable html gtk-doc-html)
	$(use_enable introspection)"

src_prepare() {
	gnome2_src_prepare
	sed 's:bindings::g' -i Makefile.in || die
}
