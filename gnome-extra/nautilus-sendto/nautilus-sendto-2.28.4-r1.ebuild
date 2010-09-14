# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-sendto/nautilus-sendto-2.28.4-r1.ebuild,v 1.6 2010/09/14 17:41:56 josejx Exp $

EAPI="2"

inherit gnome2 multilib eutils autotools

DESCRIPTION="A nautilus extension for sending files to locations"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~sparc x86"
IUSE="bluetooth doc gajim cdr pidgin upnp +mail"

RDEPEND=">=x11-libs/gtk+-2.18
	>=dev-libs/glib-2.6
	>=gnome-base/nautilus-2.14
	>=gnome-base/gconf-2.13.0
	bluetooth? (
		|| ( >=net-wireless/gnome-bluetooth-2.27
			 >=net-wireless/bluez-gnome-1.8 )
		>=dev-libs/dbus-glib-0.60 )
	cdr? ( >=app-cdr/brasero-2.26.0[nautilus] )
	gajim? (
		net-im/gajim
		>=dev-libs/dbus-glib-0.60 )
	mail? ( >=gnome-extra/evolution-data-server-1.5.3 )
	pidgin? (
		>=net-im/pidgin-2.0.0
		>=dev-libs/dbus-glib-0.60 )
	upnp? ( >=net-libs/gupnp-0.13.0 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1.9 )
	>=gnome-base/gnome-common-0.12
	dev-util/gtk-doc-am"
# Needed for eautoreconf
#	>=gnome-base/gnome-common-0.12
#	dev-util/gtk-doc-am

DOCS="AUTHORS ChangeLog NEWS README"

_use_plugin() {
	if use ${1}; then
		G2CONF="${G2CONF}${2:-"${1}"},"
	fi
}

pkg_setup() {
	G2CONF="${G2CONF}
		--with-plugins=removable-devices,"
	_use_plugin bluetooth
	_use_plugin cdr nautilus-burn
	_use_plugin mail evolution
	_use_plugin pidgin
	_use_plugin gajim
	_use_plugin upnp
}

src_prepare() {
	gnome2_src_prepare

	# Compile with -DGSEAL_ENABLE
	epatch "${FILESDIR}/${P}-gseal-enable.patch"

	# Make the last selected medium's widget grab focus
	epatch "${FILESDIR}/${P}-item-focus.patch"

	# Fix thunderbird's mailto command
	epatch "${FILESDIR}/${P}-thunderbird-command.patch"

	# Remove plugin to use sendto from Evolution
	epatch "${FILESDIR}/${P}-remove-old-evo.patch"

	# Remove Empathy plugin since it now lives in Empathy itself.
	epatch "${FILESDIR}/${P}-remove-empathy.patch"

	# Never unload plugins that use D-Bus internally
	epatch "${FILESDIR}/${P}-unload-dbus.patch"

	# Never unload modules once init() has been done
	epatch "${FILESDIR}/${P}-unload-init.patch"

	# Remove never_unload from the plugin struct
	epatch "${FILESDIR}/${P}-unload.patch"

	# Fix handling of shadowed mounts
	epatch "${FILESDIR}/${P}-shadowed-mounts.patch"

	eautoreconf
}

src_install() {
	gnome2_src_install

	# Nautilus does not use *.la files
	find "${D}/usr/$(get_libdir)/nautilus" -name "*.la" -delete \
		|| die "failed to delete *.la files"
}

pkg_postinst() {
	gnome2_pkg_postinst

	if ! use mail; then
		ewarn "You have disabled mail support, this will remove support for all mail clients"
	fi
}
