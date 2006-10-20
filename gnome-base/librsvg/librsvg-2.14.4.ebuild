# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/librsvg/librsvg-2.14.4.ebuild,v 1.10 2006/10/20 16:37:35 agriffis Exp $

inherit eutils multilib gnome2 autotools

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="http://librsvg.sourceforge.net/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="doc gnome zlib"

RDEPEND=">=media-libs/fontconfig-1.0.1
	>=x11-libs/gtk+-2
	>=dev-libs/glib-2
	>=dev-libs/libxml2-2.4.7
	>=x11-libs/pango-1.2
	>=x11-libs/cairo-1.0.2
	>=dev-libs/popt-1.5
	>=dev-libs/libcroco-0.6.1
	>=media-libs/freetype-2
	zlib? ( >=gnome-extra/libgsf-1.6 )
	gnome? ( >=gnome-base/gnome-vfs-2 )"
# libgnomeprint dependencies are not necessary

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-0.9 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"


set_gtk_confdir() {

	# An arch specific config directory is used on multilib systems
	has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0}

}

pkg_setup() {

	if ! built_with_use x11-libs/cairo png; then
		einfo "Please re-emerge x11-libs/cairo with the png USE flag set"
		die "cairo needs the png flag set"
	fi

	G2CONF="--with-croco \
		--enable-pixbuf-loader \
		--enable-gtk-theme \
		--disable-mozilla-plugin \
		$(use_enable gnome gnome-vfs) \
		$(use_with zlib svgz)"

}

src_install() {
	gnome2_src_install plugindir=/usr/$(get_libdir)/nsbrowser/plugins/

	# remove gdk-pixbuf loaders (#47766)
	rm -fr ${D}/etc

	# remove plugins dir since we disable the plugin
	rm -fr ${D}/usr/lib/nsbrowser
}

pkg_postinst() {
	set_gtk_confdir
	gdk-pixbuf-query-loaders > ${GTK2_CONFDIR}/gdk-pixbuf.loaders
}

pkg_postrm() {
	set_gtk_confdir
	gdk-pixbuf-query-loaders > ${GTK2_CONFDIR}/gdk-pixbuf.loaders
}
