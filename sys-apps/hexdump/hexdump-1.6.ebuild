# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hexdump/hexdump-1.6.ebuild,v 1.7 2004/11/03 16:31:44 corsair Exp $

inherit toolchain-funcs

DESCRIPTION="Eric Raymond's hex dumper"
HOMEPAGE="http://www.catb.org/~esr/hexdump/"
SRC_URI="http://www.catb.org/~esr/hexdump/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="hppa ppc x86 ~ppc64"
IUSE=""

src_compile() {
	emake CC="$(tc-getCC) $CFLAGS" || die
}

src_install() {
	dobin hexdump || die
	doman hexdump.1
	dodoc README
	dosym hexdump /usr/bin/hex
}
