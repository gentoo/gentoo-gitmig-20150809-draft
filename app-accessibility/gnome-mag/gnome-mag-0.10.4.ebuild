# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-mag/gnome-mag-0.10.4.ebuild,v 1.1 2004/03/17 22:04:43 leonardop Exp $

inherit gnome2

DESCRIPTION="Gnome magnification service definition"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="x86 sparc hppa alpha ia64 ~amd64 ppc"

IUSE="debug"

RDEPEND=">=gnome-base/libbonobo-2
	>=gnome-base/ORBit2-2.4
	>=gnome-extra/at-spi-0.12.1
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.2
	dev-libs/popt"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

G2CONF="${G2CONF} $(use_enable debug)"

MAKEOPTS="${MAKEOPTS} -j1"

DOCS="AUTHORS ChangeLog COPYING NEWS README"
