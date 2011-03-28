# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/empathy/empathy-2.34.0.ebuild,v 1.2 2011/03/28 20:59:44 eva Exp $

EAPI="3"
GCONF_DEBUG="yes"
PYTHON_DEPEND="2:2.4"

inherit eutils gnome2 multilib python

DESCRIPTION="Telepathy client and library using GTK+"
HOMEPAGE="http://live.gnome.org/Empathy"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# FIXME: Add location support once geoclue stops being idiotic with automagic deps
IUSE="eds map nautilus networkmanager spell test webkit"

# FIXME: libnotify & libcanberra hard deps
# gst-plugins-bad is required for the valve plugin. This should move to good
# eventually at which point the dep can be dropped
RDEPEND=">=dev-libs/glib-2.27.2:2
	>=x11-libs/gtk+-2.22:2
	>=dev-libs/dbus-glib-0.51
	>=net-libs/telepathy-glib-0.14.1
	>=media-libs/libcanberra-0.4[gtk]
	>=x11-libs/libnotify-0.7
	>=gnome-base/gnome-keyring-2.26
	>=net-libs/gnutls-2.8.5
	>=dev-libs/folks-0.4

	>=dev-libs/libunique-1.1.6:1
	net-libs/farsight2
	>=media-libs/gstreamer-0.10.32:0.10
	>=media-libs/gst-plugins-base-0.10.32:0.10
	media-libs/gst-plugins-bad
	media-plugins/gst-plugins-gconf
	>=net-libs/telepathy-farsight-0.0.14
	dev-libs/libxml2
	x11-libs/libX11
	net-voip/telepathy-connection-managers
	>=net-im/telepathy-logger-0.2.0

	eds? ( >=gnome-extra/evolution-data-server-1.2 )
	map? (
		>=media-libs/libchamplain-0.7.1:0.8[gtk]
		>=media-libs/clutter-gtk-0.10:0.10 )
	nautilus? ( >=gnome-extra/nautilus-sendto-2.31.7 )
	networkmanager? ( >=net-misc/networkmanager-0.7 )
	spell? (
		>=app-text/enchant-1.2
		>=app-text/iso-codes-0.35 )
	webkit? ( >=net-libs/webkit-gtk-1.1.15:2 )
"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.17.3
	>=dev-util/intltool-0.35.0
	>=dev-util/pkgconfig-0.16
	test? (
		sys-apps/grep
		>=dev-libs/check-0.9.4 )
	dev-libs/libxslt
"
PDEPEND=">=net-im/telepathy-mission-control-5.7.6"

pkg_setup() {
	DOCS="CONTRIBUTORS AUTHORS ChangeLog NEWS README"

	# call support needs unreleased telepathy-farstream
	G2CONF="${G2CONF}
		--enable-silent-rules
		--disable-coding-style-checks
		--disable-schemas-compile
		--disable-static
		--disable-call
		--disable-location
		--disable-control-center-embedding
		--disable-Werror
		$(use_enable debug)
		$(use_with eds)
		$(use_enable map)
		$(use_enable nautilus nautilus-sendto)
		$(use_with networkmanager connectivity nm)
		$(use_enable spell)
		$(use_enable webkit)"

	# Build time python tools needs python2
	python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare
	python_convert_shebangs -r 2 .
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	emake check || die "emake check failed."
}

src_install() {
	gnome2_src_install
	# nautilus-sendto plugin doesn't need this
	find "${ED}" -name "*.la" -delete
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog "Empathy needs telepathy's connection managers to use any IM protocol."
	elog "See the USE flags on net-voip/telepathy-connection-managers"
	elog "to install them."
}
