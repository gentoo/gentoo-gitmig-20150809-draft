# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-1.99.0.ebuild,v 1.16 2004/03/17 00:50:44 geoman Exp $

inherit gnome2 gnuconfig

DESCRIPTION="GL extensions for gtk+"
HOMEPAGE="http://www.gnome.org/"

SLOT="2"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ~mips"

DEPEND="virtual/glibc
	>=x11-libs/gtk+-2.0.3
	virtual/glu
	virtual/opengl"

src_compile() {

	use mips && gnuconfig_update
	econf || die
	emake || die

}

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README* docs/*.txt"
