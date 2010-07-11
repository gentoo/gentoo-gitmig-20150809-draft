# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gossip/gossip-0.31.ebuild,v 1.8 2010/07/11 14:02:52 pacho Exp $

inherit gnome2 eutils

DESCRIPTION="Lightweight Jabber client for GNOME"
HOMEPAGE="http://developer.imendio.com/projects/gossip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ppc64 sparc x86"
IUSE="dbus eds galago gnome-keyring libnotify spell test"

RDEPEND="x11-libs/libXScrnSaver
	>=dev-libs/glib-2.12.1
	>=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2
	>=gnome-base/gconf-1.2
	>=dev-libs/libxml2-2.6.16
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=net-libs/loudmouth-1.4.1
	eds? ( >=gnome-extra/evolution-data-server-1.2 )
	spell? ( app-text/aspell
		>=app-text/iso-codes-1.5 )
	libnotify? ( >=x11-libs/libnotify-0.4.1 )
	galago? ( dev-libs/libgalago )
	dbus? ( >=dev-libs/dbus-glib-0.71 )
	gnome-keyring? ( gnome-base/gnome-keyring )"
DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.3.2
	app-text/scrollkeeper
	test? ( ~app-text/docbook-xml-dtd-4.1.2 )
	dev-util/pkgconfig
	>=dev-util/intltool-0.35
	x11-proto/scrnsaverproto"

DOCS="AUTHORS README COPYING ChangeLog INSTALL NEWS README CONTRIBUTORS"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable dbus)
		$(use_enable eds ebook)
		$(use_enable galago)
		$(use_enable gnome-keyring)
		$(use_enable libnotify)
		$(use_enable spell aspell)"
}

pkg_postinst() {
	gnome2_pkg_postinst

	ewarn "If you are upgrading from <net-im/gossip-0.28 any previously	registred"
	ewarn "accounts will be dropped. However history will not be removed."
}
