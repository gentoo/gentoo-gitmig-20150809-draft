# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-control-center/gnome-control-center-3.2.2-r1.ebuild,v 1.1 2012/02/14 10:43:43 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes" # gmodule is used, which uses dlopen

inherit autotools eutils gnome2

DESCRIPTION="GNOME Desktop Configuration Tool"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
IUSE="+cheese +colord +cups +networkmanager +socialweb"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"

# XXX: gnome-desktop-2.91.5 is needed for upstream commit c67f7efb
# XXX: NetworkManager-0.9 support is automagic, make hard-dep once it's released
#
# gnome-session-2.91.6-r1 is needed so that 10-user-dirs-update is run at login
# Latest gsettings-desktop-schemas is neededfor commit 73f9bffb
# gnome-settings-daemon-3.1.4 is needed for power panel (commit 4f08a325)
COMMON_DEPEND="
	>=dev-libs/glib-2.29.14:2
	>=x11-libs/gdk-pixbuf-2.23.0:2
	>=x11-libs/gtk+-3.1.19:3
	>=gnome-base/gsettings-desktop-schemas-3.0.2
	>=gnome-base/gconf-2.0:2
	>=dev-libs/dbus-glib-0.73
	>=gnome-base/gnome-desktop-3.1.0:3
	>=gnome-base/gnome-settings-daemon-3.1.4[colord(+)?]
	>=gnome-base/libgnomekbd-2.91.91

	app-text/iso-codes
	dev-libs/libxml2:2
	gnome-base/gnome-menus:3
	gnome-base/libgtop:2
	media-libs/fontconfig
	net-libs/gnome-online-accounts

	>=media-libs/libcanberra-0.13[gtk3]
	>=media-sound/pulseaudio-0.9.16[glib]
	>=sys-auth/polkit-0.97
	>=sys-power/upower-0.9.1
	>=x11-libs/libnotify-0.7.3

	x11-apps/xmodmap
	x11-libs/libX11
	x11-libs/libXxf86misc
	>=x11-libs/libxklavier-5.1
	>=x11-libs/libXi-1.2

	cheese? (
		media-libs/gstreamer:0.10
		>=media-video/cheese-2.91.91.1 )
	colord? ( >=x11-misc/colord-0.1.8 )
	cups? ( >=net-print/cups-1.4[dbus] )
	networkmanager? (
		>=gnome-extra/nm-applet-0.9.1.90
		>=net-misc/networkmanager-0.8.997 )
	socialweb? ( net-libs/libsocialweb )"
# <gnome-color-manager-3.1.2 has file collisions with g-c-c-3.1.x
RDEPEND="${COMMON_DEPEND}
	app-admin/apg
	sys-apps/accountsservice
	x11-themes/gnome-icon-theme-symbolic
	cups? ( net-print/cups-pk-helper )

	!<gnome-base/gdm-2.91.94
	!<gnome-extra/gnome-color-manager-3.1.2
	!gnome-extra/gnome-media[pulseaudio]
	!<gnome-extra/gnome-media-2.32.0-r300"
# PDEPEND to avoid circular dependency
PDEPEND=">=gnome-base/gnome-session-2.91.6-r1"
DEPEND="${COMMON_DEPEND}
	x11-proto/xproto
	x11-proto/xf86miscproto
	x11-proto/kbproto

	>=sys-devel/gettext-0.17
	>=dev-util/intltool-0.40.1
	>=dev-util/pkgconfig-0.19

	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.10.1

	cups? ( sys-apps/sed )

	gnome-base/gnome-common"
# Needed for autoreconf
#	gnome-base/gnome-common

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-update-mimedb
		--disable-static
		$(use_with cheese)
		$(use_enable colord color)
		$(use_enable cups)
		$(use_with socialweb libsocialweb)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	# Upstream patch to not crash on missing metacity; will be in next release
	epatch "${FILESDIR}/${P}-metacity-gconf.patch"

	# bug #403527, https://bugzilla.gnome.org/show_bug.cgi?id=670042
	epatch "${FILESDIR}/${P}-timezone-free.patch"

	# https://bugzilla.gnome.org/show_bug.cgi?id=670051, requires eautoreconf
	epatch "${FILESDIR}/${P}-timezones-linguas.patch"

	# Make colord plugin optional; requires eautoreconf
	epatch "${FILESDIR}/${PN}-3.2.1-optional-colord.patch"
	eautoreconf

	gnome2_src_prepare
}
