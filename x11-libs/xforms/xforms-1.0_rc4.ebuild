# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xforms/xforms-1.0_rc4.ebuild,v 1.1 2002/07/29 05:01:59 owen Exp $

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://world.std.com/~xforms"
SRC_URI="ftp://ncmir.ucsd.edu/pub/xforms/OpenSource/xforms-1.0RC4.tgz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ppc"
DEPEND="virtual/x11"

S="${WORKDIR}/xforms-1.0RC4"

src_compile() {
	xmkmf -a
	cp Makefile Makefile.orig
	sed -e s/'demos$'// Makefile.orig > Makefile
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
}
