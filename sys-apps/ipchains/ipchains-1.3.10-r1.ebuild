# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ipchains/ipchains-1.3.10-r1.ebuild,v 1.7 2002/07/21 19:58:55 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="legacy Linux firewall/packet mangling tools"
SRC_URI="http://netfilter.kernelnotes.org/ipchains/${P}.tar.gz"
HOMEPAGE="http://netfilter.filewatcher.org/ipchains/"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s/= -g -O/= ${CFLAGS}/" Makefile.orig > Makefile
	cd ${S}/libipfwc
	mv Makefile Makefile.orig
	sed -e "s/= -g -O/= ${CFLAGS}/" Makefile.orig > Makefile
}

src_compile() {
	make clean || die
	emake all || die
}

src_install() {
	into /
	dosbin ipchains
	doman ipfw.4 ipchains.8
	dodoc COPYING README
	docinto ps
	dodoc ipchains-quickref.ps
}


