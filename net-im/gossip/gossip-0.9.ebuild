# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gossip/gossip-0.9.ebuild,v 1.7 2006/04/17 18:00:30 corsair Exp $

inherit gnome2 eutils

DESCRIPTION="Lightweight Jabber client for GNOME"
HOMEPAGE="http://developer.imendio.com/wiki/Gossip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc ~x86"
IUSE=""

RDEPEND="|| ( x11-libs/libXScrnSaver
		virtual/x11 )
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2
	>=gnome-base/gconf-1.2
	>=dev-libs/libxml2-2.4.7
	>=dev-libs/libxslt-1
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=net-libs/loudmouth-1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

# Disable dbus support by default considering it's experimental nature
G2CONF="${G2CONF} --disable-dbus"

DOCS="AUTHORS README COPYING ChangeLog INSTALL NEWS README"

USE_DESTDIR="1"
