# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libgxps/libgxps-0.2.0.ebuild,v 1.1 2011/11/23 20:25:50 tetromino Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="Library for handling and rendering XPS documents"
HOMEPAGE="http://live.gnome.org/libgxps"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc +introspection jpeg lcms static-libs tiff"

RDEPEND=">=app-arch/libarchive-2.8
	>=dev-libs/glib-2.24:2
	media-libs/freetype:2
	media-libs/libpng:0
	>=x11-libs/cairo-1.10[svg]
	introspection? ( >=dev-libs/gobject-introspection-0.10.1 )
	jpeg? ( virtual/jpeg )
	lcms? ( media-libs/lcms:2 )
	tiff? ( media-libs/tiff[zlib] )"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	dev-util/pkgconfig
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1.14 )

	dev-util/gtk-doc-am"
# eautoreconf requires: dev-util/gtk-doc-am

# There is no automatic test suite, only an interactive test application
RESTRICT="test"

pkg_setup() {
	G2CONF="${G2CONF}
		--enable-man
		--disable-test
		$(use_enable debug)
		$(use_enable introspection)
		$(use_with jpeg libjpeg)
		$(use_with lcms liblcms2)
		$(use_enable static-libs static)
		$(use_with tiff libtiff)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	# Upstream patch to fix linking, in next release, requires eautoreconf
	epatch "${FILESDIR}/${P}-libm.patch"

	# https://bugzilla.gnome.org/show_bug.cgi?id=664666
	epatch "${FILESDIR}/${PN}-0.2.0-libpng15.patch"

	eautoreconf
	gnome2_src_prepare
}
