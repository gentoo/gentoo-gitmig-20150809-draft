# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lha/lha-114i-r4.ebuild,v 1.3 2004/11/01 09:58:05 usata Exp $

inherit eutils flag-o-matic

DESCRIPTION="Utility for creating and opening lzh archives"
HOMEPAGE="http://www2m.biglobe.ne.jp/~dolphin/lha/lha-unix.htm"
SRC_URI="http://www2m.biglobe.ne.jp/~dolphin/lha/prog/${P}.tar.gz"

LICENSE="lha"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 ppc64 ppc-macos"
IUSE=""

DEPEND="virtual/libc"

src_unpack () {
	unpack ${A} ; cd ${S}
	cd src
	epatch ${FILESDIR}/${P}.diff
	epatch ${FILESDIR}/${PN}-command_buffer.patch
	epatch ${FILESDIR}/${P}-symlink.patch
	epatch ${FILESDIR}/${PN}-dir_length_bounds_check.patch
}

src_compile() {
	use ppc-macos && append-flags -DHAVE_NO_LCHOWN
	sed -i -e "/^OPTIMIZE/ s:-O2:${CFLAGS}:" Makefile
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
