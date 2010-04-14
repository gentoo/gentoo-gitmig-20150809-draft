# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/hippo-canvas/hippo-canvas-0.3.0-r1.ebuild,v 1.2 2010/04/14 02:32:28 elvanor Exp $

EAPI="2"

GCONF_DEBUG="no"
G2PUNT_LA="yes"
inherit eutils gnome2

DESCRIPTION="A canvas library based on GTK+-2, Cairo, and Pango"
HOMEPAGE="http://live.gnome.org/HippoCanvas"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc python"

RDEPEND=">=dev-libs/glib-2.6
	dev-libs/libcroco
	>=x11-libs/gtk+-2.6
	x11-libs/pango
	gnome-base/librsvg
	python? ( dev-lang/python
		dev-python/pycairo
		dev-python/pygtk )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS README TODO"

pkg_setup() {
	G2CONF="$(use_enable python)"
}

src_prepare() {
	cd "$S/python"
	epatch "${FILESDIR}/${PN}-python-override.patch"
}

src_configure() {
	econf --disable-static
}

src_install() {
	gnome2_src_install
	rm "${D}/usr/lib/python2.6/site-packages/hippo.la"
	rm "${D}/usr/lib/libhippocanvas-1.la"
}
