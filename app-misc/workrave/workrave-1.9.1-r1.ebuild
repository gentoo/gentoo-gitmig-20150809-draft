# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/workrave/workrave-1.9.1-r1.ebuild,v 1.7 2011/03/16 09:24:00 nirbheek Exp $

EAPI="2"

inherit eutils gnome2

DESCRIPTION="Helpful utility to attack Repetitive Strain Injury (RSI)"
HOMEPAGE="http://workrave.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="dbus doc distribution gnome gstreamer nls test xml"

RDEPEND=">=dev-libs/glib-2.10:2
	>=gnome-base/gconf-2:2
	>=x11-libs/gtk+-2.8:2
	>=dev-cpp/gtkmm-2.10:2.4
	>=dev-cpp/glibmm-2.10:2
	>=dev-libs/libsigc++-2
	dbus? (
		>=sys-apps/dbus-1.2
		dev-libs/dbus-glib )
	distribution? ( net-libs/gnet:2 )
	gnome? (
		|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
		>=gnome-base/libbonobo-2
		>=gnome-base/orbit-2.8.3 )
	gstreamer? (
		>=media-libs/gstreamer-0.10:0.10
		>=media-libs/gst-plugins-base-0.10:0.10 )
	xml? ( dev-libs/gdome2 )
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXt
	x11-libs/libXmu"

DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/inputproto
	x11-proto/recordproto
	dev-python/cheetah
	>=dev-util/pkgconfig-0.9
	doc? (
		app-text/docbook-sgml-utils
		app-text/xmlto )
	nls? ( sys-devel/gettext )"
# Currently freezes workrave

DOCS="AUTHORS NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--without-arts
		--disable-kde
		--enable-gconf
		$(use_enable dbus)
		$(use_enable doc manual)
		$(use_enable distribution)
		$(use_enable gnome)
		$(use_enable gstreamer)
		$(use_enable nls)
		$(use_enable test tests)
		$(use_enable xml)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix intltool tests
	echo "frontend/gtkmm/src/gnome_applet/Workrave-Applet.server.in" >> po/POTFILES.skip

	# Fix crash when building without gstreamer support; bug #316637
	epatch "${FILESDIR}/${P}-nogst-crash.patch"

	# Fix build with new gtkmm due API break reported in bug #327471
	epatch "${FILESDIR}/${P}-gtkmm_api.patch"
}
