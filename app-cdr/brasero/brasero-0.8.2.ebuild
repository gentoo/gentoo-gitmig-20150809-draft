# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/brasero/brasero-0.8.2.ebuild,v 1.9 2009/01/23 17:00:41 loki_val Exp $

EAPI=1

GCONF_DEBUG=no

inherit gnome2 autotools

DESCRIPTION="Brasero (aka Bonfire) is yet another application to burn CD/DVD for the gnome desktop."
HOMEPAGE="http://www.gnome.org/projects/brasero"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="beagle +dvd gnome +libburn totem"

RDEPEND=">=dev-libs/glib-2.15.6
	>=x11-libs/gtk+-2.12.0
	gnome? ( >=gnome-base/libgnome-2.22.0
		>=gnome-base/libgnomeui-2.22.0 )
	>=media-libs/gstreamer-0.10.15
	>=media-libs/gst-plugins-base-0.10.15
	>=media-plugins/gst-plugins-ffmpeg-0.10
	>=dev-libs/libxml2-2.6
	sys-apps/hal
	gnome-base/gvfs
	app-cdr/cdrdao
	virtual/cdrtools
	>=dev-libs/dbus-glib-0.7.2
	dvd? ( media-libs/libdvdcss
		app-cdr/dvd+rw-tools )
	totem? ( >=dev-libs/totem-pl-parser-2.20 )
	beagle? ( >=dev-libs/libbeagle-0.3.0 )
	libburn? ( >=dev-libs/libburn-0.4.0
		>=dev-libs/libisofs-0.6.4 )"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool
	gnome-base/gconf"

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper
		--disable-caches
		--disable-dependency-tracking
		$(use_enable totem playlist)
		$(use_enable beagle search)
		$(use_enable libburn libburnia)
		$(use_enable gnome gnome2)"

	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/-DGTK_DISABLE_DEPRECATED/d' \
		src/Makefile.am \
		|| die "404"

	echo "data/brasero-copy-medium.desktop.in" >> po/POTFILES.skip
	echo "data/brasero-open-image.desktop.in" >> po/POTFILES.skip
	echo "data/brasero-open-playlist.desktop.in" >> po/POTFILES.skip
	echo "data/brasero-open-project.desktop.in" >> po/POTFILES.skip

	eautoreconf

	# Prevent scrollkeeper access violations
	gnome2_omf_fix

	# Run libtoolize
	elibtoolize ${ELTCONF}
}

src_test() {
	BLING=$LINGUAS
	unset LINGUAS
	make check
	export LINGUAS=$BLING
	unset BLING
}

pkg_postinst() {
	gnome2_pkg_postinst
	echo
	elog "To use the libburn backend you need to add USE=libburn and activate"
	elog "it in gconf editor. Note that the default backend is cdrtools/cdrkit."
	echo
}
