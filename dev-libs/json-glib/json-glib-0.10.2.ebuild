# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/json-glib/json-glib-0.10.2.ebuild,v 1.7 2011/02/25 23:55:49 xmw Exp $

EAPI="2"

inherit gnome2 eutils

DESCRIPTION="A library providing GLib serialization and deserialization support for the JSON format"
HOMEPAGE="http://live.gnome.org/JsonGlib"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE="doc +introspection"

RDEPEND=">=dev-libs/glib-2.15"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1.11 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.3 )"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable introspection)"
}
