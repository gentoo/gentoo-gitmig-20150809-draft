# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netcat/netcat-110.ebuild,v 1.7 2002/08/30 16:36:37 seemant Exp $

MY_P=nc${PV}
S=${WORKDIR}/nc-${PV}
DESCRIPTION="A network piping program"
SRC_URI="http://www.l0pht.com/~weld/netcat/${MY_P}.tgz"
HOMEPAGE="http://www.l0pht.com/~weld/netcat"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"

src_unpack() {
	mkdir ${S}
	cd ${S}
	tar zxf ${DISTDIR}/${A}
}

src_compile() {

	cp Makefile Makefile.orig
	sed -e "s:^CFLAGS =.*$:CFLAGS = ${CFLAGS}:" \
		-e "s:^CC =.*$:CC = gcc \$(CFLAGS):" \
		Makefile.orig > Makefile

	cp netcat.c netcat.orig
	sed -e "s:#define HAVE_BIND:#undef HAVE_BIND:" \
		netcat.c.orig > netcat.c

	make linux || die

}

src_install () {
	dobin nc
	dodoc README
	docinto scripts
	dodoc scripts/*
}
