# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gossip/gossip-0.15.ebuild,v 1.1 2006/08/30 20:40:12 foser Exp $

inherit gnome2 eutils

DESCRIPTION="Lightweight Jabber client for GNOME"
HOMEPAGE="http://developer.imendio.com/wiki/Gossip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="spell dbus libnotify"

RDEPEND="|| ( x11-libs/libXScrnSaver
		virtual/x11 )
	>=dev-libs/glib-2.8
	>=x11-libs/gtk+-2.8
	>=gnome-base/libglade-2
	>=gnome-base/gconf-1.2
	>=dev-libs/libxml2-2.6.16
	>=dev-libs/libxslt-1
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=net-libs/loudmouth-1
	spell? ( app-text/aspell )
	libnotify? ( >=x11-libs/libnotify-0.3.2 )
	dbus? ( >=sys-apps/dbus-0.60 )"

DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.3.2
	app-text/scrollkeeper
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

G2CONF="${G2CONF} \
	$(use_enable dbus) \
	$(use_enable libnotify) \
	$(use_enable spell aspell)"

DOCS="AUTHORS README COPYING ChangeLog INSTALL NEWS README CONTRIBUTORS TODO"

