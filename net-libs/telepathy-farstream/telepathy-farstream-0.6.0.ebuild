# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-farstream/telepathy-farstream-0.6.0.ebuild,v 1.2 2012/12/31 14:41:32 ago Exp $

EAPI="5"

inherit eutils

DESCRIPTION="Telepathy client library that uses Farstream to handle Call channels"
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/3"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="examples +introspection"

RDEPEND="
	>=dev-libs/glib-2.32:2
	>=sys-apps/dbus-0.60
	>=dev-libs/dbus-glib-0.60
	media-libs/gstreamer:1.0[introspection?]
	>=net-libs/telepathy-glib-0.19[introspection?]
	net-libs/farstream:0.2[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-1.30 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.17
	virtual/pkgconfig
"

src_configure() {
	econf \
		--disable-static \
		--disable-Werror \
		$(use_enable introspection)
}

src_install() {
	default
	prune_libtool_files

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c
		insinto /usr/share/doc/${PF}/examples/python
		doins examples/python/*.py
	fi
}
