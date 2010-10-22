# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/workrave/workrave-1.9.2.ebuild,v 1.2 2010/10/22 14:36:31 eva Exp $

EAPI="2"

inherit eutils gnome2 python

DESCRIPTION="Helpful utility to attack Repetitive Strain Injury (RSI)"
HOMEPAGE="http://www.workrave.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbus doc distribution gnome gstreamer nls pulseaudio test xml"

RDEPEND=">=dev-libs/glib-2.10
	>=gnome-base/gconf-2
	>=x11-libs/gtk+-2.8
	>=dev-cpp/gtkmm-2.10
	>=dev-cpp/glibmm-2.10
	>=dev-libs/libsigc++-2
	dbus? (
		>=sys-apps/dbus-1.2
		dev-libs/dbus-glib )
	distribution? ( >=net-libs/gnet-2 )
	gnome? (
		>=gnome-base/gnome-panel-2.0.10
		>=gnome-base/libbonobo-2
		>=gnome-base/orbit-2.8.3 )
	gstreamer? (
		>=media-libs/gstreamer-0.10
		>=media-libs/gst-plugins-base-0.10 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.15 )
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
		$(use_enable pulseaudio pulse)
		$(use_enable test tests)
		$(use_enable xml)"

	python_set_active_version 2
}
