# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdnet/libdnet-1.8.ebuild,v 1.4 2005/02/27 05:35:30 ka0ttic Exp $

DESCRIPTION="simplified, portable interface to several low-level networking routines"
HOMEPAGE="http://libdnet.sourceforge.net/"
SRC_URI="mirror://sourceforge/libdnet/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~ia64 ~amd64 ~ppc-macos"
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
