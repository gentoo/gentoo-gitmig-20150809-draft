# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/clutter-gtk/clutter-gtk-0.91.6.ebuild,v 1.1 2010/12/24 12:05:26 nirbheek Exp $

EAPI="2"

# inherit clutter after gnome2 so that defaults aren't overriden
inherit gnome2 clutter

DESCRIPTION="Clutter-GTK - GTK+ Integration library for Clutter"

SLOT="1.0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="doc debug examples +introspection"

# XXX: Needs gtk with X support (!directfb)
RDEPEND="
	>=x11-libs/gtk+-2.91.0:3[introspection?]
	>=media-libs/clutter-1.2:1.0[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/gettext-0.17
	doc? ( >=dev-util/gtk-doc-1.14 )"
EXAMPLES="examples/{*.c,redhand.png}"

pkg_setup() {
	G2CONF="${G2CONF}
		--with-flavour=x11
		--enable-maintainer-flags=no
		$(use_enable introspection)"
}
