# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-2.4.1.ebuild,v 1.4 2004/01/29 12:47:10 agriffis Exp $

inherit gnome2

DESCRIPTION="Utilities for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"

IUSE="ipv6"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc alpha sparc hppa ~amd64 ia64"

RDEPEND=">=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/gnome-desktop-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2.4
	>=gnome-base/gnome-panel-2
	>=gnome-base/gconf-1.2.1
	sys-fs/e2fsprogs
	app-text/scrollkeeper
	dev-libs/popt"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} $(use_enable ipv6)"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS"
