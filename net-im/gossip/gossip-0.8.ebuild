# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gossip/gossip-0.8.ebuild,v 1.1 2005/01/08 15:21:20 foser Exp $

inherit gnome2

DESCRIPTION="Lightweight Jabber client for GNOME"
HOMEPAGE="http://gossip.imendio.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

RDEPEND=">=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2
	>=gnome-base/gconf-1.2
	>=dev-libs/libxml2-2.4.7
	>=dev-libs/libxslt-1
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=net-libs/loudmouth-0.17.1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

# Disable dbus support by default considering it's experimental nature
G2CONF="${G2CONF} --disable-dbus"

DOCS="AUTHORS README COPYING ChangeLog INSTALL NEWS README"

USE_DESTDIR="1"
