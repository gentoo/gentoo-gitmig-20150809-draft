# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-2.3.90.ebuild,v 1.1 2003/09/07 22:07:15 foser Exp $

inherit gnome2

DESCRIPTION="Utilities for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"

IUSE="ipv6"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64"

RDEPEND=">=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.1
	>=gnome-base/gnome-desktop-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gnome-panel-2
	>=gnome-base/gconf-1.2.1
	sys-apps/e2fsprogs
	app-text/scrollkeeper
	dev-libs/popt"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS"

use ipv6 \
	&& G2CONF="${G2CONF} --enable-ipv6 " \
	|| G2CONF="${G2CONF} --disable-ipv6 " \

