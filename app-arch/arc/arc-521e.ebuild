# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arc/arc-521e.ebuild,v 1.6 2003/02/13 05:52:44 vapier Exp $

DESCRIPTION="Create & extract files from DOS .ARC files."
MY_P="${PN}${PV}.pl8"
SRC_URI="ftp://ftp.kiarchive.ru/pub/unix/arcers/${MY_P}.tar.Z"
HOMEPAGE=""

KEYWORDS="x86 -ppc"
SLOT="0"
LICENSE="ARC"

DEPEND="virtual/glibc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	patch -p1 < ${FILESDIR}/${P}-timeh.patch
	cat marc.c | sed -e 's/char \*arctemp2, \*mktemp();/char *arctemp2;/' \
	-e 's/mktemp/mkstemp/g' > marc.c.new
	mv marc.c.new  marc.c
	cat arc.c | sed -e 's/\*arctemp2, \*mktemp();/*arctemp2;/g' \
	-e 's/mktemp/mkstemp/g' > arc.c.new
	mv arc.c.new arc.c

	cp Makefile Makefile.orig
	sed "s:\$(OPT):${CFLAGS}:" Makefile.orig >Makefile
}

src_compile() {
	emake || die
}

src_install() {
	into /usr
	dobin arc marc
	doman arc.1
}
