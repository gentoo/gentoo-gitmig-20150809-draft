# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/at-poke/at-poke-0.2.1.ebuild,v 1.1 2004/03/18 00:06:56 leonardop Exp $

inherit gnome2

DESCRIPTION="the accessibility poking tool"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 sparc"
SLOT="0"

RDEPEND=">=gnome-extra/at-spi-1.1.5
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-extra/libgail-gnome-0.5.0
	>=dev-libs/popt-1.5"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} --enable-platform-gnome-2"

DOCS="AUTHORS COPYING COPYING.LIB ChangeLog INSTALL NEWS README TODO"
