# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bin86/bin86-0.16.16.ebuild,v 1.1 2004/11/30 02:35:41 vapier Exp $

DESCRIPTION="Assembler and loader used to create kernel bootsector"
HOMEPAGE="http://www.cix.co.uk/~mayday/"
SRC_URI="http://www.cix.co.uk/~mayday/dev86/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:/man/man1:/share/man/man1:' Makefile || die "sed"
}

src_compile() {
	emake PREFIX="/usr" CFLAGS="${CFLAGS} -D_POSIX_SOURCE" || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	make install PREFIX="${D}/usr" || die "install"
	dodoc README* ChangeLog
}
