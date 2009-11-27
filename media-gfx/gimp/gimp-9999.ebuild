# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-9999.ebuild,v 1.22 2009/11/27 00:06:42 lu_zero Exp $

EAPI=2

inherit git eutils gnome2 fdo-mime multilib python

EGIT_REPO_URI="git://git.gnome.org/gimp"

DESCRIPTION="GNU Image Manipulation Program"
HOMEPAGE="http://www.gimp.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="2"
KEYWORDS=""

IUSE="alsa aalib altivec curl dbus debug doc exif gnome hal jpeg lcms mmx mng pdf png python smp sse svg tiff webkit wmf"

RDEPEND=">=dev-libs/glib-2.18.1
	>=x11-libs/gtk+-2.12.5
	>=x11-libs/pango-1.18.0
	>=media-libs/freetype-2.1.7
	>=media-libs/fontconfig-2.2.0
	sys-libs/zlib
	dev-libs/libxml2
	dev-libs/libxslt
	x11-misc/xdg-utils
	x11-themes/hicolor-icon-theme
	>=media-libs/gegl-0.0.22
	aalib? ( media-libs/aalib )
	alsa? ( media-libs/alsa-lib )
	curl? ( net-misc/curl )
	dbus? ( dev-libs/dbus-glib )
	hal? ( sys-apps/hal )
	gnome? ( gnome-base/gvfs )
	webkit? ( net-libs/webkit-gtk )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	exif? ( >=media-libs/libexif-0.6.15 )
	lcms? ( media-libs/lcms )
	mng? ( media-libs/libmng )
	pdf? ( >=virtual/poppler-glib-0.3.1[cairo] )
	png? ( >=media-libs/libpng-1.2.2 )
	python?	( >=dev-lang/python-2.5.0
		>=dev-python/pygtk-2.10.4 )
	tiff? ( >=media-libs/tiff-3.5.7 )
	svg? ( >=gnome-base/librsvg-2.8.0 )
	wmf? ( >=media-libs/libwmf-0.2.8 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog* HACKING NEWS README*"

src_prepare() {
	sed -i -e 's:\$srcdir/configure:#:g' autogen.sh
	./autogen.sh
	gnome2_src_prepare
}

src_unpack() {
	git_src_unpack
}

pkg_setup() {
	G2CONF="--enable-default-binary \
		--with-x \
		$(use_with aalib aa) \
		$(use_with alsa) \
		$(use_enable altivec) \
		$(use_with curl libcurl) \
		$(use_with dbus) \
		$(use_with hal) \
		$(use_with gnome gvfs) \
		--without-gnomevfs \
		$(use_with webkit) \
		$(use_with jpeg libjpeg) \
		$(use_with exif libexif) \
		$(use_with lcms) \
		$(use_enable mmx) \
		$(use_with mng libmng) \
		$(use_with pdf poppler) \
		$(use_with png libpng) \
		$(use_enable python) \
		$(use_enable smp mp) \
		$(use_enable sse) \
		$(use_with svg librsvg) \
		$(use_with tiff libtiff) \
		$(use_with wmf)"
}

pkg_postinst() {
	gnome2_pkg_postinst

	python_mod_optimize /usr/$(get_libdir)/gimp/2.0/python \
		/usr/$(get_libdir)/gimp/2.0/plug-ins
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/gimp/2.0/python \
		/usr/$(get_libdir)/gimp/2.0/plug-ins
}
