# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memtester/memtester-4.0.3.ebuild,v 1.3 2004/09/03 21:03:24 pvdabeel Exp $

inherit fixheadtails gcc

DESCRIPTION="Memory testing utility"
HOMEPAGE="http://www.qcc.sk.ca/~charlesc/software/memtester/"
SRC_URI="http://www.qcc.sk.ca/~charlesc/software/memtester/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~amd64"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "$(gcc-getCC) ${CFLAGS} -DPOSIX -c" > conf-cc
	ht_fix_file Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dosbin memtester || die "dosbin failed"
	doman memtester.8
	dodoc BUGS CHANGELOG README README.tests
}
