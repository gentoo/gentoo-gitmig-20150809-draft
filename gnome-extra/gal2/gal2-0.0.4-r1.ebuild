# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gal2/gal2-0.0.4-r1.ebuild,v 1.9 2003/02/13 12:16:48 vapier Exp $

inherit gnome2

DESCRIPTION="A text editor for the Gnome2 desktop"
SRC_URI="mirror://gnome/2.0.0/sources/gal2/gal2-0-${PV}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 sparc "

MAKEOPTS="-j1"

DEPEND="virtual/glibc
	gnome-base/libgnomeprint
	gnome-base/libgnomeprintui
	gnome-base/libglade
	gnome-base/libgnomeui
	gnome-base/libgnomecanvas
	dev-libs/libxml2"

S=${WORKDIR}/gal2-0-${PV}

DOCS="AUTHORS BUGS ChangeLog COPYING COPYING.LIB FAQ INSTALL NEWS README* THANKS TODO"
