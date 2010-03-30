# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-sendto/nautilus-sendto-2.28.4.ebuild,v 1.1 2010/03/30 16:18:02 pacho Exp $

EAPI="2"

inherit gnome2 multilib

DESCRIPTION="A nautilus extension for sending files to locations"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="bluetooth doc empathy gajim cdr pidgin upnp" # +mail

# FIXME: mail plugin build is broken and not needed with evo-2.28, 
# see https://bugzilla.gnome.org/579099
#	mail? ( >=gnome-extra/evolution-data-server-1.5.3 )
RDEPEND=">=x11-libs/gtk+-2.12
	>=dev-libs/glib-2.6
	>=gnome-base/nautilus-2.14
	>=gnome-base/gconf-2.13.0
	bluetooth? (
		|| ( >=net-wireless/gnome-bluetooth-2.27
			 >=net-wireless/bluez-gnome-1.8 )
		>=dev-libs/dbus-glib-0.60 )
	cdr? (
		|| ( >=app-cdr/brasero-2.26.0[nautilus]
			 >=gnome-extra/nautilus-cd-burner-2.24.0 ) )
	empathy? ( >=net-im/empathy-2.27.91 )
	gajim? (
		net-im/gajim
		>=dev-libs/dbus-glib-0.60 )
	pidgin? (
		>=net-im/pidgin-2.0.0
		>=dev-libs/dbus-glib-0.60 )
	upnp? ( >=net-libs/gupnp-0.13.0 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1.9 )"
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
#	_use_plugin mail evolution
	_use_plugin empathy
	_use_plugin pidgin
	_use_plugin gajim
	_use_plugin upnp
}

src_prepare() {
	gnome2_src_prepare

	# FIXME: skip evolution, it does not build properly
	sed 's/evolution//g' -i Makefile.{am,in} || die "sed failed"
}

src_install() {
	gnome2_src_install

	# Nautilus does not use *.la files
	find "${D}/usr/$(get_libdir)/nautilus" -name "*.la" -delete \
		|| die "failed to delete *.la files"
}

pkg_postinst() {
	gnome2_pkg_postinst

#	if ! use mail; then
#		ewarn "You have disabled mail support, this will remove support for all mail clients"
#	fi
}
