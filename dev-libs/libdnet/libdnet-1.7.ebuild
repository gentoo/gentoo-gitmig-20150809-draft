# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdnet/libdnet-1.7.ebuild,v 1.14 2006/02/25 15:11:43 jokey Exp $

DESCRIPTION="simplified, portable interface to several low-level networking routines"
HOMEPAGE="http://libdnet.sourceforge.net/"
SRC_URI="mirror://sourceforge/libdnet/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa ia64 amd64"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's/suite_free(s);//' test/check/*.c || die "sed failed"
}

src_install () {
	einstall || die
	dodoc ChangeLog VERSION README
}
