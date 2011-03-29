# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/hippo-canvas/hippo-canvas-0.3.0.ebuild,v 1.4 2011/03/29 13:00:14 angelos Exp $

EAPI="2"

GCONF_DEBUG="no"
G2PUNT_LA="yes"
inherit gnome2

DESCRIPTION="A canvas library based on GTK+-2, Cairo, and Pango"
HOMEPAGE="http://live.gnome.org/HippoCanvas"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"

IUSE="doc python"

RDEPEND=">=dev-libs/glib-2.6:2
	dev-libs/libcroco
	>=x11-libs/gtk+-2.6:2
	x11-libs/pango
	python? ( dev-lang/python
		dev-python/pycairo
		dev-python/pygtk:2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS README TODO"

pkg_setup() {
	G2CONF="$(use_enable python)"
}
