# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mm/mm-1.3.0.ebuild,v 1.6 2004/04/10 00:18:05 kumba Exp $

inherit libtool

DESCRIPTION="Shared Memory Abstraction Library"
HOMEPAGE="http://www.ossp.org/pkg/lib/mm/"
SRC_URI="ftp://ftp.ossp.org/pkg/lib/mm/${P}.tar.gz"

DEPEND="virtual/glibc"

LICENSE="as-is"
SLOT="1.2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ia64 mips"

src_compile() {
	elibtoolize
	econf --host=${CHOST} || die "bad ./configure"
	make || die "compile problem"
	make test || die "testing problem"
}

src_install() {
	einstall || die
	dodoc README LICENSE ChangeLog INSTALL PORTING THANKS

	dosym /usr/lib/libmm.so /usr/lib/libmm.so.1
}
