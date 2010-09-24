# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/librsvg/librsvg-2.31.0.ebuild,v 1.2 2010/09/24 23:24:10 nirbheek Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2 multilib eutils autotools

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="http://librsvg.sourceforge.net/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc +gtk tools" # +gtk3

RDEPEND=">=media-libs/fontconfig-1.0.1
	>=media-libs/freetype-2
	>=dev-libs/glib-2.24
	>=x11-libs/cairo-1.2
	>=x11-libs/pango-1.10
	>=dev-libs/libxml2-2.4.7
	>=dev-libs/libcroco-0.6.1
	|| ( x11-libs/gdk-pixbuf
		x11-libs/gtk+:2 )
	gtk? ( >=x11-libs/gtk+-2.16:2 )"
#	gtk3? ( >=x11-libs/gtk+-2.90:3 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12
	>=dev-util/gtk-doc-am-1.13
	doc? ( >=dev-util/gtk-doc-1 )"
# >=dev-util/gtk-doc-am-1.13 needed by eautoreconf

DOCS="AUTHORS ChangeLog README NEWS TODO"

pkg_setup() {
	# croco is forced on to respect SVG specification
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable tools)
		--with-croco
		--enable-pixbuf-loader
		$(use_with gtk gtk2)
		--without-gtk3"
#		$(use_with gtk3)"
#	if use gtk || use gtk3; then
	if use gtk; then
		G2CONF="${G2CONF} --enable-gtk-theme"
	else
		G2CONF="${G2CONF} --disable-gtk-theme"
	fi
}

src_prepare() {
	gnome2_src_prepare

	epatch "${FILESDIR}"/${P}-skip-automagic.patch

	eautoreconf
}

src_install() {
	gnome2_src_install
	
	# Remove .la files, these libraries are dlopen()-ed.
	rm -vf "${D}"/usr/lib*/gtk-2.0/*/engines/libsvg.la
	rm -vf "${D}"/usr/lib*/gdk-pixbuf-2.0/*/loaders/libpixbufloader-svg.la
}

pkg_postinst() {
	gdk-pixbuf-query-loaders > "${EROOT}/usr/$(get_libdir)/gdk-pixbuf-2.0/2.10.0/loaders.cache"
}

pkg_postrm() {
	gdk-pixbuf-query-loaders > "${EROOT}/usr/$(get_libdir)/gdk-pixbuf-2.0/2.10.0/loaders.cache"
}
