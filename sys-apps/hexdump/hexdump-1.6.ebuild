# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hexdump/hexdump-1.6.ebuild,v 1.1 2004/03/04 22:37:21 twp Exp $

DESCRIPTION="Eric Raymond's hex dumper"
HOMEPAGE="http://www.catb.org/~esr/hexdump/"
SRC_URI="http://www.catb.org/~esr/hexdump/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_compile() {
	emake CC="$CC $CFLAGS" || die
}

src_install() {
	dobin hexdump
	doman hexdump.1
	dodoc COPYING README
	dosym hexdump /usr/bin/hex
}
