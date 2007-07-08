# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gossip/gossip-0.26.ebuild,v 1.2 2007/07/08 04:36:18 mr_bones_ Exp $

inherit gnome2 eutils

DESCRIPTION="Lightweight Jabber client for GNOME"
HOMEPAGE="http://developer.imendio.com/wiki/Gossip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="spell dbus libnotify galago"

RDEPEND="|| ( x11-libs/libXScrnSaver
		virtual/x11 )
	>=dev-libs/glib-2.12.1
	>=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2
	>=gnome-base/gconf-1.2
	>=dev-libs/libxml2-2.6.16
	>=dev-libs/libxslt-1
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=net-libs/loudmouth-1.2.2
	spell? ( app-text/aspell )
	libnotify? ( >=x11-libs/libnotify-0.4.1 )
	galago? ( dev-libs/libgalago )
	dbus? ( >=dev-libs/dbus-glib-0.71 )"

DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.3.2
	app-text/scrollkeeper
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

G2CONF="${G2CONF} \
	--disable-telepathy \
	$(use_enable dbus) \
	$(use_enable libnotify) \
	$(use_enable galago) \
	$(use_enable spell aspell)"

DOCS="AUTHORS README COPYING ChangeLog INSTALL NEWS README CONTRIBUTORS TODO"
