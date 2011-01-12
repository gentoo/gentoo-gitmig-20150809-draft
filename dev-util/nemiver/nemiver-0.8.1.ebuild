# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nemiver/nemiver-0.8.1.ebuild,v 1.1 2011/01/12 23:25:36 eva Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="A gtkmm front end to the GNU Debugger (gdb)"
HOMEPAGE="http://projects.gnome.org/nemiver/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="memoryview"

RDEPEND=">=dev-libs/glib-2.16:2
	>=dev-cpp/glibmm-2.15.2:2
	>=dev-cpp/gtkmm-2.16:2.4
	dev-cpp/gtksourceviewmm:2.0
	>=x11-libs/gtksourceview-2.10:2.0
	>=gnome-base/libgtop-2.19
	>=x11-libs/vte-0.12
	>=gnome-base/gconf-2.14
	>=dev-db/sqlite-3:3
	sys-devel/gdb
	dev-libs/boost
	memoryview? ( >=app-editors/ghex-2.22 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=sys-devel/gettext-0.17
	>=dev-util/intltool-0.40
	>=app-text/scrollkeeper-0.3.11
	>=app-text/gnome-doc-utils-0.3.2
	app-text/docbook-xml-dtd:4.1.2"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		--disable-symsvis
		$(use_enable memoryview)
		--enable-sourceviewmm2
		--enable-gio
		--disable-static"
}

src_install() {
	gnome2_src_install

	find "${ED}" -type f -name "*.la" -delete || die "la files removal failed"
}
