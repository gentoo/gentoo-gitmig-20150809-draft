# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/clutter-gtk/clutter-gtk-0.10.8.ebuild,v 1.8 2011/03/21 20:36:28 xarthisius Exp $

EAPI="2"

# inherit clutter after gnome2 so that defaults aren't overriden
inherit autotools eutils gnome2 clutter

DESCRIPTION="Clutter-GTK - GTK+ Integration library for Clutter"

SLOT="0.10"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE="doc debug examples +introspection"

# XXX: Needs gtk with X support (!directfb)
RDEPEND="
	>=x11-libs/gtk+-2.19.5:2[introspection?]
	>=media-libs/clutter-1.2:1.0[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.9.3 )"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.14
	doc? ( >=dev-util/gtk-doc-1.14 )"
EXAMPLES="examples/{*.c,redhand.png}"

pkg_setup() {
	G2CONF="${G2CONF}
		--with-flavour=x11
		--enable-maintainer-flags=no
		$(use_enable introspection)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix build with USE=introspection, bug #350061
	epatch "${FILESDIR}/${PN}-0.10.8-fix-introspection-build.patch"

	eautoreconf
}
