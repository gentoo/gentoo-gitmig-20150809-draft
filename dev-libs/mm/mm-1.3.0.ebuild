# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mm/mm-1.3.0.ebuild,v 1.16 2004/11/07 14:52:01 corsair Exp $

inherit libtool

DESCRIPTION="Shared Memory Abstraction Library"
HOMEPAGE="http://www.ossp.org/pkg/lib/mm/"
SRC_URI="ftp://ftp.ossp.org/pkg/lib/mm/${P}.tar.gz"

LICENSE="as-is"
SLOT="1.2"
KEYWORDS="alpha arm hppa ia64 mips ppc s390 ~sparc ~x86 ~amd64 ppc64"
IUSE=""

DEPEND="virtual/libc"

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
