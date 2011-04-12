# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/json-glib/json-glib-0.12.4.ebuild,v 1.1 2011/04/12 22:29:15 nirbheek Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="A library providing GLib serialization and deserialization support for the JSON format"
HOMEPAGE="http://live.gnome.org/JsonGlib"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc +introspection"

RDEPEND=">=dev-libs/glib-2.16"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1.13 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.5 )"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	# Coverage support is useless, and causes runtime problems
	G2CONF="${G2CONF}
		--disable-coverage
		$(use_enable introspection)"
}
