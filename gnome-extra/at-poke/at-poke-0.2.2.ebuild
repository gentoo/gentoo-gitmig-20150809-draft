# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-poke/at-poke-0.2.2.ebuild,v 1.1 2004/03/17 14:39:23 leonardop Exp $

inherit gnome2

DESCRIPTION="The accessibility poking tool"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~sparc"
SLOT="0"

RDEPEND=">=gnome-extra/at-spi-1.3.12
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	gnome-extra/libgail-gnome
	>=dev-libs/popt-1.5"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} --enable-platform-gnome-2"

DOCS="AUTHORS ChangeLog COPYING* NEWS README TODO"
