# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdnet/libdnet-1.4.ebuild,v 1.11 2004/03/14 12:28:57 mr_bones_ Exp $

DESCRIPTION="libdnet provides a simplified, portable interface to several low-level networking routines."
HOMEPAGE="http://libdnet.sourceforge.net/"
SRC_URI="mirror://sourceforge/libdnet/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc hppa ~ia64"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	dodoc COPYING.LIB ChangeLog VERSION README
}
