# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdnet/libdnet-1.4.ebuild,v 1.5 2002/08/14 11:52:27 murphy Exp $

DESCRIPTION="libdnet provides a simplified, portable interface to several low-level networking routines."
SRC_URI="mirror://sourceforge/libdnet/${P}.tar.gz"
HOMEPAGE="http://libdnet.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	dodoc COPYING.LIB ChangeLog VERSION README
}
