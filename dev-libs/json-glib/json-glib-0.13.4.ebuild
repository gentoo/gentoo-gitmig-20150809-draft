# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/json-glib/json-glib-0.13.4.ebuild,v 1.3 2011/10/10 16:29:30 ssuominen Exp $

EAPI=4
GCONF_DEBUG=yes
GNOME2_LA_PUNT=yes

inherit gnome2

DESCRIPTION="A library providing GLib serialization and deserialization support for the JSON format"
HOMEPAGE="http://live.gnome.org/JsonGlib"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc +introspection"

RDEPEND=">=dev-libs/glib-2.26:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/gettext-0.18
	doc? ( >=dev-util/gtk-doc-1.13 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )"

pkg_setup() {
	DOCS="ChangeLog NEWS README"
	# Coverage support is useless, and causes runtime problems
	G2CONF="${G2CONF}
		--disable-gcov
		$(use_enable introspection)"
}
