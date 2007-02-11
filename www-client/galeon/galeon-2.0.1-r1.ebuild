# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/galeon/galeon-2.0.1-r1.ebuild,v 1.7 2007/02/11 00:26:17 hanno Exp $

inherit gnome2 eutils

DESCRIPTION="A GNOME Web browser based on gecko (mozilla's rendering engine)"
HOMEPAGE="http://galeon.sourceforge.net"
SRC_URI="mirror://sourceforge/galeon/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ia64 ppc sparc x86"
SLOT="0"
RDEPEND=">=www-client/mozilla-firefox-1.0.2-r1
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/libxml2-2.6.6
	>=gnome-base/gconf-2.3.2
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/libgnomeui-2.5.2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gnome-desktop-2.10.0
	>=gnome-base/libglade-2.3.1
	app-text/scrollkeeper"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.30
	>=sys-devel/gettext-0.11"

G2CONF="${G2CONF} --with-mozilla=firefox"
DOCS="AUTHORS ChangeLog FAQ README README.ExtraPrefs THANKS TODO NEWS"
