# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netcat/netcat-110.ebuild,v 1.5 2002/08/14 10:45:12 pvdabeel Exp $

MY_P=nc${PV}
S=${WORKDIR}/nc-${PV}
DESCRIPTION="A network piping program"
SRC_URI="http://www.l0pht.com/~weld/netcat/${MY_P}.tgz"
HOMEPAGE="http://www.l0pht.com/~weld/netcat"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"

src_unpack() {

	mkdir ${S}
	cd ${S}
	tar zxf ${DISTDIR}/${A}
}

src_compile() {

	cp Makefile Makefile.orig
	cat Makefile.orig | sed -e "s:^CFLAGS =.*$:CFLAGS = ${CFLAGS}:" \
	| sed -e "s:^CC =.*$:CC = gcc \$(CFLAGS):" > Makefile
	cp netcat.c netcat.orig
	cat netcat.orig | sed -e "s:#define HAVE_BIND:#undef HAVE_BIND:" > netcat.c
	try make linux

}

src_install () {

	dobin nc
	dodoc README BUGS CONTRIB LICENSE
	docinto scripts
	dodoc scripts/*

}
