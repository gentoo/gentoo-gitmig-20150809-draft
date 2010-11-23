# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany/epiphany-2.30.6.ebuild,v 1.2 2010/11/23 22:35:48 eva Exp $

EAPI="2"

inherit eutils gnome2

DESCRIPTION="GNOME webbrowser based on Webkit"
HOMEPAGE="http://www.gnome.org/projects/epiphany/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

# We are not ready for introspection yet
IUSE="avahi doc networkmanager +nss test"

# TODO: add seed support
RDEPEND=">=dev-libs/glib-2.19.7:2
	>=x11-libs/gtk+-2.19.5:2
	>=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.7
	>=x11-libs/startup-notification-0.5
	>=x11-libs/libnotify-0.4
	>=dev-libs/dbus-glib-0.71
	>=gnome-base/gconf-2
	>=app-text/iso-codes-0.35
	>=net-libs/webkit-gtk-1.2.3
	>=net-libs/libsoup-gnome-2.29.91:2.4
	>=gnome-base/gnome-keyring-2.26

	x11-libs/libICE
	x11-libs/libSM

	app-misc/ca-certificates
	x11-themes/gnome-icon-theme

	avahi? ( >=net-dns/avahi-0.6.22 )
	networkmanager? ( net-misc/networkmanager )
	nss? ( dev-libs/nss )"
#	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.40
	>=app-text/gnome-doc-utils-0.3.2
	doc? ( >=dev-util/gtk-doc-1 )"
# eautoreconf needs:
#	gnome-base/gnome-common

pkg_setup() {
	DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README TODO"
	G2CONF="${G2CONF}
		--disable-introspection
		--disable-scrollkeeper
		--disable-maintainer-mode
		--with-distributor-name=Gentoo
		$(use_enable avahi zeroconf)
		$(use_enable networkmanager network-manager)
		$(use_enable nss)
		$(use_enable test tests)"
}

src_compile() {
	# Fix sandbox error with USE="introspection" and "doc"
	# https://bugs.webkit.org/show_bug.cgi?id=35471
	addpredict "$(unset HOME; echo ~)/.local"
	gnome2_src_compile
}
