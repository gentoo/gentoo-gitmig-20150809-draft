# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/magicrescue/magicrescue-1.1.4.ebuild,v 1.3 2005/08/07 12:02:13 blubb Exp $

inherit toolchain-funcs

DESCRIPTION="Find deleted files in block devices"
HOMEPAGE="http://jbj.rapanden.dk/magicrescue/"
SRC_URI="http://jbj.rapanden.dk/magicrescue/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/libc"


src_compile() {
	./configure ||die "fake configure script failed"

	emake CC="$(tc-getCC)" GCC_OPT="${CFLAGS}" \
		|| die "make failed"
}

src_install() {
	dodir usr
	make PREFIX=${D}/usr install || die "install failed"
	mv ${D}/usr/man ${D}/usr/share
}
