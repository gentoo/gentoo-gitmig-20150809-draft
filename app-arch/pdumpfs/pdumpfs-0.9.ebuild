# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pdumpfs/pdumpfs-0.9.ebuild,v 1.1 2004/06/05 21:14:29 usata Exp $

DESCRIPTION="a daily backup system similar to Plan9's dumpfs"
HOMEPAGE="http://www.namazu.org/~satoru/pdumpfs/"
SRC_URI="http://www.namazu.org/~satoru/pdumpfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="cjk"

DEPEND="virtual/ruby"

src_compile() {

	make pdumpfs || die "make pdumpfs failed"
	make check || die "make check failed"
}

src_install() {
	dobin pdumpfs || die

	doman man/man8/pdumpfs.8
	dohtml pdumpfs.html

	if use cjk; then
		insinto /usr/share/man/ja/man8
		doins man/ja/man8/pdumpfs.8
		dohtml pdumpfs-ja.html
	fi

	dodoc ChangeLog README
}
