# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/librsvg/librsvg-2.4.0.ebuild,v 1.12 2004/04/08 10:50:48 leonardop Exp $

inherit gnome2

DESCRIPTION="SVG rendering library"
HOMEPAGE="http://librsvg.sourceforge.net/"

IUSE="doc zlib"
SLOT="2"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64"
LICENSE="GPL-2 LGPL-2"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=media-libs/libart_lgpl-2.3.10
	>=dev-libs/libxml2-2.4.7
	>=x11-libs/pango-1.1
	>=dev-libs/popt-1.5
	zlib? ( >=gnome-extra/libgsf-1.6.0 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"

# disable gimp plugin, now in gimp
G2CONF="${G2CONF} $(use_with zlib svgz) --without-gimp"

DOCS="AUTHORS ChangeLog COPYIN* README INSTALL NEWS TODO"

pkg_postinst() {

	gdk-pixbuf-query-loaders > /etc/gtk-2.0/gdk-pixbuf.loaders

}

pkg_postrm() {

	gdk-pixbuf-query-loaders > /etc/gtk-2.0/gdk-pixbuf.loaders

}
