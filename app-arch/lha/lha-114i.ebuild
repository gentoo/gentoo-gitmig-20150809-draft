# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lha/lha-114i.ebuild,v 1.12 2003/12/31 03:52:34 usata Exp $

IUSE=""

DESCRIPTION="Utility for creating and opening lzh archives."
HOMEPAGE="http://www2m.biglobe.ne.jp/~dolphin/lha/lha-unix.htm"
SRC_URI="http://www2m.biglobe.ne.jp/~dolphin/lha/prog/${P}.tar.gz"

SLOT="0"
LICENSE="lha"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/glibc"

src_unpack () {
	unpack ${A} ; cd ${S}
	sed -i -e "/^OPTIMIZE/ s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/ja/man1
	make \
		BINDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/ja \
		install MANSECT=1 || die

	dodoc *.txt *.euc *.eng
}
