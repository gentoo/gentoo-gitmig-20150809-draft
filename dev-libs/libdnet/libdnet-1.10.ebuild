# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdnet/libdnet-1.10.ebuild,v 1.1 2005/03/23 01:39:35 vanquirius Exp $

inherit eutils

DESCRIPTION="simplified, portable interface to several low-level networking routines"
HOMEPAGE="http://libdnet.sourceforge.net/"
SRC_URI="mirror://sourceforge/libdnet/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~ia64 ~amd64"
IUSE="python"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's/suite_free(s);//' test/check/*.c || die "sed failed"
}

src_compile () {
	econf $(use_with python) || die "econf failed"
	emake || die "emake failed"
}

src_test() {
	einfo "self test fails with permission problems"
}

src_install () {
	emake DESTDIR=${D} install || die "make install failed"
	dodoc README
}
