# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgail-gnome/libgail-gnome-1.0.2.ebuild,v 1.4 2003/06/29 22:39:05 darkspecter Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="GAIL libraries for Gnome2 "
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha"
LICENSE="LGPL-2"


RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libbonobo-2
	>=gnome-extra/at-spi-1
	>=dev-libs/atk-1.0.3
	>=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"




