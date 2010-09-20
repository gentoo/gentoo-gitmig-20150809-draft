# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mm/mm-1.3.0.ebuild,v 1.22 2010/09/20 02:43:50 jer Exp $

inherit libtool

DESCRIPTION="Shared Memory Abstraction Library"
HOMEPAGE="http://www.ossp.org/pkg/lib/mm/"
SRC_URI="ftp://ftp.ossp.org/pkg/lib/mm/${P}.tar.gz"

LICENSE="as-is"
SLOT="1.2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	elibtoolize
}

src_test() {
	make test || die "testing problem"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README ChangeLog INSTALL PORTING THANKS
	dosym libmm.so /usr/lib/libmm.so.1
}
