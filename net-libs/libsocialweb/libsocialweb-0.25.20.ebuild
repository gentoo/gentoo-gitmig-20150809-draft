# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsocialweb/libsocialweb-0.25.20.ebuild,v 1.5 2012/06/05 08:19:13 jlec Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="2"

inherit eutils gnome2 python

DESCRIPTION="Social web services integration framework"
HOMEPAGE="http://git.gnome.org/browse/libsocialweb"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc connman +gnome +introspection +networkmanager vala"

# NOTE: coverage testing should not be enabled
RDEPEND=">=dev-libs/glib-2.14:2
	>=net-libs/rest-0.7.10

	gnome-base/gconf:2
	gnome-base/libgnome-keyring
	dev-libs/dbus-glib
	dev-libs/json-glib
	net-libs/libsoup:2.4

	gnome? ( >=net-libs/libsoup-gnome-2.25.1:2.4 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )
	networkmanager? ( net-misc/networkmanager )
	!networkmanager? ( connman? ( net-misc/connman ) )"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.15
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	sys-devel/gettext
	doc? (
		dev-libs/libxslt
		>=dev-util/gtk-doc-1.15 )
	vala? (
		>=dev-lang/vala-0.10.0:0.12[vapigen]
		>=dev-libs/gobject-introspection-0.9.6 )"

# Introspection is needed for vala bindings
REQUIRED_USE="vala? ( introspection )"

pkg_setup() {
	# TODO: enable sys-apps/keyutils support (--without-kernel-keyring)
	G2CONF="${G2CONF}
		--disable-static
		--disable-gcov
		--without-kernel-keyring
		--enable-all-services
		$(use_enable introspection)
		$(use_enable vala vala-bindings)
		$(use_with gnome)
		VALAC=$(type -P valac-0.12)
		VAPIGEN=$(type -P vapigen-0.12)
		--with-online=always"

	# NetworkManager always overrides connman support
	use connman && G2CONF="${G2CONF} --with-online=connman"
	use networkmanager && G2CONF="${G2CONF} --with-online=networkmanager"

	DOCS="AUTHORS README TODO"

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Sent upstream, gnome bug 677445
	epatch "${FILESDIR}"/${P}-gold.patch
	gnome2_src_prepare

	python_convert_shebangs 2 "${S}/tools/glib-ginterface-gen.py"
}
