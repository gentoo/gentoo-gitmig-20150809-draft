# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hexdump/hexdump-1.6.ebuild,v 1.5 2004/09/03 21:03:23 pvdabeel Exp $

DESCRIPTION="Eric Raymond's hex dumper"
HOMEPAGE="http://www.catb.org/~esr/hexdump/"
SRC_URI="http://www.catb.org/~esr/hexdump/${P}.tar.gz"
SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="x86 ppc hppa"

src_compile() {
	emake CC="$CC $CFLAGS" || die
}

src_install() {
	dobin hexdump
	doman hexdump.1
	dodoc COPYING README
	dosym hexdump /usr/bin/hex
}
