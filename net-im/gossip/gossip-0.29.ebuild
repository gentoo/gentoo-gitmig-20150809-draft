# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gossip/gossip-0.29.ebuild,v 1.1 2008/05/21 22:00:05 eva Exp $

inherit gnome2 eutils autotools

DESCRIPTION="Lightweight Jabber client for GNOME"
HOMEPAGE="http://developer.imendio.com/wiki/Gossip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dbus eds galago gnome-keyring libnotify spell"

RDEPEND="x11-libs/libXScrnSaver
	>=dev-libs/glib-2.12.1
	>=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2
	>=gnome-base/gconf-1.2
	>=dev-libs/libxml2-2.6.16
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=net-libs/loudmouth-1.3.4
	eds? ( >=gnome-extra/evolution-data-server-1.2 )
	spell? ( app-text/aspell )
	libnotify? ( >=x11-libs/libnotify-0.4.1 )
	galago? ( dev-libs/libgalago )
	dbus? ( >=dev-libs/dbus-glib-0.71 )
	gnome-keyring? ( gnome-base/gnome-keyring )"
DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.3.2
	app-text/scrollkeeper
	dev-util/pkgconfig
	x11-proto/scrnsaverproto
	>=dev-util/intltool-0.35"

DOCS="AUTHORS README COPYING ChangeLog INSTALL NEWS README CONTRIBUTORS TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		${mydebug}
		$(use_enable dbus)
		$(use_enable eds ebook)
		$(use_enable galago)
		$(use_enable gnome-keyring)
		$(use_enable libnotify)
		$(use_enable spell aspell)"
}

pkg_postinst() {
	gnome2_pkg_postinst

	ewarn "This version will drop any previously registred accounts."
	ewarn "However it does not drop history."
}
