# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nemiver/nemiver-0.7.3.ebuild,v 1.1 2009/12/21 22:11:28 eva Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="A gtkmm front end to the GNU Debugger (gdb)"
HOMEPAGE="http://projects.gnome.org/nemiver/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="memoryview"

RDEPEND=">=dev-libs/glib-2.16
	>=dev-cpp/glibmm-2.15.2
	>=dev-cpp/gtkmm-2.16.0
	>=dev-cpp/libglademm-2.6.0
	dev-cpp/gtksourceviewmm
	>=gnome-base/libgtop-2.19.0
	>=x11-libs/vte-0.12.0
	>=gnome-base/gconf-2.14.0
	>=dev-db/sqlite-3.0
	sys-devel/gdb
	dev-libs/boost
	memoryview? ( >=app-editors/ghex-2.22.0 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	>=app-text/scrollkeeper-0.3.11
	>=app-text/gnome-doc-utils-0.3.2
	app-text/docbook-xml-dtd:4.1.2"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-symsvis
		$(use_enable memoryview)
		--enable-sourceviewmm2
		--enable-gio
		--disable-static"
}
