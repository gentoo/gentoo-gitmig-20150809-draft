# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/brasero/brasero-3.6.1.ebuild,v 1.2 2012/12/16 14:07:18 eva Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2
if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

DESCRIPTION="CD/DVD burning application for the GNOME desktop"
HOMEPAGE="http://projects.gnome.org/brasero/"

LICENSE="GPL-2+"
SLOT="0"
IUSE="+css +introspection +libburn mp3 nautilus packagekit playlist test tracker"
if [[ ${PV} = 9999 ]]; then
	IUSE="${IUSE} doc"
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
fi

COMMON_DEPEND="
	>=dev-libs/glib-2.29.14:2
	>=x11-libs/gtk+-3:3[introspection?]
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	>=dev-libs/libxml2-2.6:2
	>=x11-libs/libnotify-0.6.1

	media-libs/libcanberra[gtk3]
	x11-libs/libICE
	x11-libs/libSM

	introspection? ( >=dev-libs/gobject-introspection-0.6.3 )
	libburn? (
		>=dev-libs/libburn-0.4
		>=dev-libs/libisofs-0.6.4 )
	nautilus? ( >=gnome-base/nautilus-2.91.90 )
	playlist? ( >=dev-libs/totem-pl-parser-2.29.1 )
	tracker? ( >=app-misc/tracker-0.12 )"
RDEPEND="${COMMON_DEPEND}
	media-libs/gst-plugins-good:1.0
	x11-themes/hicolor-icon-theme
	css? ( media-libs/libdvdcss:1.2 )
	!libburn? (
		app-cdr/cdrdao
		app-cdr/dvd+rw-tools
		virtual/cdrtools )
	mp3? (
		media-libs/gst-plugins-ugly:1.0
		media-plugins/gst-plugins-mad:1.0 )
	packagekit? ( app-admin/packagekit-base )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	>=dev-util/gtk-doc-am-1.12
	gnome-base/gnome-common:3
	sys-devel/gettext
	virtual/pkgconfig
	test? ( app-text/docbook-xml-dtd:4.3 )"
# eautoreconf deps
#	gnome-base/gnome-common
PDEPEND="gnome-base/gvfs"

if [[ ${PV} = 9999 ]]; then
	DEPEND="${DEPEND}
		app-text/yelp-tools
		doc? ( >=dev-util/gtk-doc-1.12 )"
fi

src_configure() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
	G2CONF="${G2CONF}
		--disable-caches
		$(use_enable !libburn cdrtools)
		$(use_enable !libburn cdrkit)
		$(use_enable !libburn cdrdao)
		$(use_enable !libburn growisofs)
		$(use_enable introspection)
		$(use_enable libburn libburnia)
		$(use_enable nautilus)
		$(use_enable playlist)
		$(use_enable tracker search)"
	[[ ${PV} != 9999 ]] && G2CONF="${G2CONF} ITSTOOL=$(type -P true)"

	gnome2_src_configure
}

pkg_postinst() {
	gnome2_pkg_postinst

	echo
	elog "If ${PN} doesn't handle some music or video format, please check"
	elog "your USE flags on media-plugins/gst-plugins-meta"
}
