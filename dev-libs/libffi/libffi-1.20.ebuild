# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-1.20.ebuild,v 1.15 2005/03/05 10:44:24 corsair Exp $

DESCRIPTION="Support library for Foreign Functions Interfaces"
SRC_URI="ftp://sourceware.cygnus.com/pub/libffi/${P}.tar.gz"
HOMEPAGE="http://sources.redhat.com/libffi/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog LICENSE
}
