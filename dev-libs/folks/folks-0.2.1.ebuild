# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/folks/folks-0.2.1.ebuild,v 1.8 2011/03/22 18:49:57 ranger Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="libfolks is a library that aggregates people from multiple sources"
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Folks"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

# docs require valadoc
RDEPEND=">=dev-libs/glib-2.24:2
	>=net-libs/telepathy-glib-0.11.16[vala]
	dev-libs/dbus-glib
	<dev-libs/libgee-0.7
	dev-libs/libxml2
"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.21
	dev-lang/vala:0.10[vapigen]
	>=dev-libs/gobject-introspection-0.9.12
"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF}
		VALAC=$(type -p valac-0.10)
		VAPIGEN=$(type -p vapigen-0.10)
		--disable-docs
		--enable-import-tool
		--disable-Werror"
}

src_prepare() {
	gnome2_src_prepare

	# Test suite is badly broken, even from git repo
	sed 's/tests//' -i Makefile.am Makefile.in || die "sed failed"
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "la files removal failed"
}
