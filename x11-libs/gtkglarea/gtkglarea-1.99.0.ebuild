# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-1.99.0.ebuild,v 1.10 2003/05/28 19:49:25 agriffis Exp $

inherit gnome2

DESCRIPTION="GL extensions for gtk+"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/sources/gtkglarea/1.99/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="2"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/glibc
	>=x11-libs/gtk+-2.0.3
	virtual/glu
	virtual/opengl"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README* docs/*.txt"
