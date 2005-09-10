# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mdcrack/mdcrack-1.2.ebuild,v 1.3 2005/09/10 22:47:30 vanquirius Exp $

inherit eutils

DESCRIPTION="A MD4/MD5/NTML hashes bruteforcer."
HOMEPAGE="http://mdcrack.df.ru/"
SRC_URI="http://mdcrack.df.ru/download/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="ncurses"
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc4.diff
}

src_compile() {
	use ncurses || \
		sed -i -e 's/^NCURSES/#NCURSES/g' \
			-e 's/^LDFLAGS/#LDFLAGS/g' Makefile
	sed -i "s,^\(CFLAGS =\).*,\1 ${CFLAGS},g" Makefile

	#endian
	emake little || die "emake failed"
}

src_test() {
	make fulltest ||die 'self test failed'
}

src_install() {
	dobin bin/mdcrack
	dodoc BENCHMARKS CREDITS FAQ README TODO VERSIONS WWW
}
