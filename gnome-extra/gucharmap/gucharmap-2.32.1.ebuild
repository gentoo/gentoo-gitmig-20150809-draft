# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gucharmap/gucharmap-2.32.1.ebuild,v 1.3 2011/02/24 20:15:06 tomka Exp $

EAPI="3"
GCONF_DEBUG="yes"
PYTHON_DEPEND="2:2.4"

inherit gnome2 python

DESCRIPTION="Unicode character map viewer"
HOMEPAGE="http://live.gnome.org/Gucharmap"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="cjk doc gnome +introspection python test"

RDEPEND=">=dev-libs/glib-2.16.3
	>=x11-libs/pango-1.2.1
	>=x11-libs/gtk+-2.14:2
	gnome? ( gnome-base/gconf )
	introspection? ( >=dev-libs/gobject-introspection-0.6 )
	python? ( >=dev-python/pygtk-2.7.1 )"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.40
	>=app-text/gnome-doc-utils-0.9.0
	doc? ( >=dev-util/gtk-doc-1.0 )
	test? ( ~app-text/docbook-xml-dtd-4.1.2 )"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-scrollkeeper
		--disable-maintainer-mode
		--with-gtk=2.0
		$(use_enable gnome gconf)
		$(use_enable introspection)
		$(use_enable cjk unihan)
		$(use_enable python python-bindings)"
	DOCS="ChangeLog NEWS README TODO"
	python_set_active_version 2
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "remove of la files failed"
}
