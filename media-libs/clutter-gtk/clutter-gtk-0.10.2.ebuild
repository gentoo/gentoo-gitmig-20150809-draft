# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/clutter-gtk/clutter-gtk-0.10.2.ebuild,v 1.1 2010/02/26 22:06:06 nirbheek Exp $

EAPI="2"

# inherit clutter after gnome2 so that defaults aren't overriden
inherit gnome2 clutter

DESCRIPTION="Clutter-GTK - GTK+ Integration library for Clutter"

SLOT="1.0"
KEYWORDS="~amd64 ~x86"
IUSE="doc debug examples introspection"

# XXX: Needs gtk with X support (!directfb)
RDEPEND="
	>=x11-libs/gtk+-2.12
	media-libs/clutter:1.0[opengl]"
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1.11 )
	introspection? (
		media-libs/clutter[introspection]
		>=dev-libs/gobject-introspection-0.6.3
		>=dev-libs/gir-repository-0.6.3[gtk] )"
EXAMPLES="examples/{*.c,redhand.png}"

pkg_setup() {
	G2CONF="${G2CONF}
		--with-flavour=x11
		--enable-maintainer-flags=no
		$(use_enable introspection)"
}
