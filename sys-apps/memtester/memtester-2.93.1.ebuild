# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memtester/memtester-2.93.1.ebuild,v 1.3 2003/02/28 13:18:14 liquidx Exp $

DESCRIPTION="Memory testing utility, ppc safe"

HOMEPAGE="http://www.qcc.sk.ca/~charlesc/software/memtester/"

SRC_URI="http://www.qcc.sk.ca/~charlesc/software/memtester/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="ppc"

IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	make || die
}

src_install() {
#	make DESTDIR=${D} install || die
	into /usr
	dosbin memtest
}
