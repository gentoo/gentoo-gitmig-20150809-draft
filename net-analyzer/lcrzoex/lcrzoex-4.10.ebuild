# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/lcrzoex/lcrzoex-4.10.ebuild,v 1.2 2002/07/17 19:49:21 drobbins Exp $

DESCRIPTION="Toolbox of over 300 utilities for testing Ethernet/IP networks"
HOMEPAGE="http://www.laurentconstantin.com/en/lcrzoex/"
SRC_URI="http://www.laurentconstantin.com/common/${PN}/download/v4/${P}-src.tgz"
S=${WORKDIR}/${P}-src
KEYWORDS="x86"
DEPEND="virtual/glibc =net-libs/lcrzo-${PV}*"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${A} ; cd ${S}/src
	./genemake || die "problem creating Makefile"
	mv Makefile Makefile.orig
	sed -e "s:^\(GCCOPT=\).*:\1${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	make -C src || die "compile problem"
}

src_install() {
	into /usr
	dosbin src/lcrzoex
	doman doc/man/lcrzoex_en.1
	dodoc doc/*.txt
}
