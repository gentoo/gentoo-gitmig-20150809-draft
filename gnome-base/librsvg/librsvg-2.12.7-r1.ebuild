# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/librsvg/librsvg-2.12.7-r1.ebuild,v 1.1 2006/07/03 16:15:16 allanonjl Exp $

inherit eutils multilib gnome2

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="http://librsvg.sourceforge.net/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="doc gnome zlib"

RDEPEND=">=media-libs/fontconfig-1.0.1
	>=x11-libs/gtk+-2
	>=dev-libs/glib-2
	>=media-libs/libart_lgpl-2.3.10
	>=dev-libs/libxml2-2.4.7
	>=x11-libs/pango-1.2
	>=dev-libs/popt-1.5
	media-libs/freetype
	>=dev-libs/libcroco-0.6
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
	# FIXME : USEify croco support (?)
	G2CONF="--with-croco \
		--enable-pixbuf-loader        \
		--enable-gtk-theme            \
		--disable-mozilla-plugin		\
		$(use_enable gnome gnome-vfs) \
		$(use_with zlib svgz)"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Provide gecko toolkit autodetection and --with-mozilla switch.
	epatch ${FILESDIR}/${PN}-2.12.6-plugin_checks.patch

	autoconf || die "autoconf failed"
}

src_install() {
	gnome2_src_install plugindir=/usr/$(get_libdir)/nsbrowser/plugins/

	# remove gdk-pixbuf loaders (#47766)
	rm -fr ${D}/etc
}

pkg_postinst() {
	set_gtk_confdir
	gdk-pixbuf-query-loaders > ${GTK2_CONFDIR}/gdk-pixbuf.loaders
}

pkg_postrm() {
	set_gtk_confdir
	gdk-pixbuf-query-loaders > ${GTK2_CONFDIR}/gdk-pixbuf.loaders
}
