# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-1.99.0.ebuild,v 1.3 2002/08/14 13:05:59 murphy Exp $

inherit gnome2
S=${WORKDIR}/${P}
DESCRIPTION="GL extensions for gtk+"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/gtkglarea/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc
	>=x11-libs/gtk+-2.0.3
	virtual/glu
	virtual/opengl"
RDEPEND=${DEPEND}

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README* docs/*.txt"

