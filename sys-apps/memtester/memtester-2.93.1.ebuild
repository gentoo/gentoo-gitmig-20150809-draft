# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memtester/memtester-2.93.1.ebuild,v 1.4 2003/12/13 16:28:28 vapier Exp $

DESCRIPTION="Memory testing utility, ppc safe"
HOMEPAGE="http://www.qcc.sk.ca/~charlesc/software/memtester/"
SRC_URI="http://www.qcc.sk.ca/~charlesc/software/memtester/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc"

DEPEND=""

src_compile() {
	make || die
}

src_install() {
	dosbin memtest
	doman memtest.1
	dodoc CHANGELOG README.test ABOUT BUGS
}
