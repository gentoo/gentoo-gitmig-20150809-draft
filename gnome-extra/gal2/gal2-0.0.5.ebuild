# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gal2/gal2-0.0.5.ebuild,v 1.2 2002/08/16 04:13:57 murphy Exp $

inherit gnome2

S=${WORKDIR}/gal2-0-${PV}
DESCRIPTION="A text editor for the Gnome2 desktop"
SRC_URI="mirror://gnome/sources/gal2/gal2-0-${PV}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 sparc sparc64"

MAKEOPTS="-j1"

DEPEND="virtual/glibc
	>=gnome-base/libgnomeprint-1.116.0
	>=gnome-base/libgnomeprintui-1.116.0
	>=gnome-base/libglade-2.0.0
	>=gnome-base/libgnomeui-2.0.3
	>=gnome-base/libgnomecanvas-2.0.2
	>=dev-libs/libxml2-2.4.23"

RDEPEND=${DEPEND}

DOCS="AUTHORS BUGS ChangeLog COPYING COPYING.LIB FAQ INSTALL NEWS  README*  THANKS TODO"

