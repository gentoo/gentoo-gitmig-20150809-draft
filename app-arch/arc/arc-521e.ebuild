# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arc/arc-521e.ebuild,v 1.9 2003/11/26 10:58:29 aliz Exp $

DESCRIPTION="Create & extract files from DOS .ARC files."
MY_P="${PN}${PV}.pl8"
SRC_URI="ftp://ftp.kiarchive.ru/pub/unix/arcers/${MY_P}.tar.Z"
HOMEPAGE=""

KEYWORDS="x86 -ppc ~alpha ~amd64"
SLOT="0"
LICENSE="ARC"

DEPEND="virtual/glibc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-timeh.patch
	sed -i -e 's/char \*arctemp2, \*mktemp();/char *arctemp2;/' \
		-e 's/mktemp/mkstemp/g' marc.c
	sed -i -e 's/\*arctemp2, \*mktemp();/*arctemp2;/g' \
		-e 's/mktemp/mkstemp/g' arc.c

	sed -i "s:\$(OPT):${CFLAGS}:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	into /usr
	dobin arc marc
	doman arc.1
}
