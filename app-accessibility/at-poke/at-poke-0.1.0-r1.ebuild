# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/at-poke/at-poke-0.1.0-r1.ebuild,v 1.1 2004/03/18 00:06:56 leonardop Exp $

inherit gnome2

DESCRIPTION="the accessibility poking tool"
HOMEPAGE="http://bugzilla.gnome.org"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 sparc"

RDEPEND=">=gnome-extra/at-spi-0.12.1
	>=x11-libs/gtk+-2.0.0
	>=gnome-base/libgnomeui-1.117.0
	>=gnome-extra/libgail-gnome-0.5.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
S=${WORKDIR}/${P}
SLOT="0"

G2CONF="${G2CONF} --enable-platform-gnome-2"

DOCS="AUTHORS COPYING COPYING.LIB ChangeLog INSTALL NEWS README TODO"
