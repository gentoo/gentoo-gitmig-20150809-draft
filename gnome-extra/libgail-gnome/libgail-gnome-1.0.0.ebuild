# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgail-gnome/libgail-gnome-1.0.0.ebuild,v 1.4 2002/08/16 04:13:58 murphy Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="GAIL libraries for Gnome2 "
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="LGPL-2"


RDEPEND=">=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-extra/at-spi-1.0.1
	>=dev-libs/atk-1.0.0"
	
#	>=gnome-base/gnome-common-1.2.4-r1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"


DOCS="AUTHORS  COPYING ChangeLog INSTALL NEWS README"




