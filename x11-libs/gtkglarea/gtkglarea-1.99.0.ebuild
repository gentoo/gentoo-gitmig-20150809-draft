# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-1.99.0.ebuild,v 1.22 2004/07/30 03:40:49 tgall Exp $

inherit gnome2 gnuconfig

DESCRIPTION="GL extensions for gtk+"
HOMEPAGE="http://www.gnome.org/"
IUSE=""
SLOT="2"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips ppc64"

DEPEND="virtual/libc
	>=x11-libs/gtk+-2.0.3
	virtual/glu
	virtual/opengl"

src_compile() {

	gnuconfig_update
	econf || die
	emake || die

}

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README* docs/*.txt"
