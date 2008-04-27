# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsoup/libsoup-2.2.105-r2.ebuild,v 1.2 2008/04/27 19:02:30 jer Exp $

inherit gnome2 eutils

DESCRIPTION="An HTTP library implementation in C"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2.2"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc ssl"

RDEPEND=">=dev-libs/glib-2.12
	>=dev-libs/libxml2-2
	ssl? ( >=net-libs/gnutls-1 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable ssl)"
}

src_unpack() {
	gnome2_src_unpack

	# Fix GNOME bug #518384 - API docs not found by devhelp
	epatch "${FILESDIR}/${P}-fix-devhelp-docs.patch"
	mv "${S}"/docs/reference/html/libsoup{,-2.2}.devhelp
	mv "${S}"/docs/reference/html/libsoup{,-2.2}.devhelp2
	mv "${S}"/docs/reference/libsoup{,-2.2}-docs.sgml
	mv "${S}"/docs/reference/libsoup{,-2.2}-overrides.txt
	mv "${S}"/docs/reference/libsoup{,-2.2}-sections.txt
	mv "${S}"/docs/reference/libsoup{,-2.2}.types
}
