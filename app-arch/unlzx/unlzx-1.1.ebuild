# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unlzx/unlzx-1.1.ebuild,v 1.16 2003/11/25 03:42:44 agriffis Exp $

DESCRIPTION="Unarchiver for Amiga LZX archives"
SRC_URI="ftp://us.aminet.net/pub/aminet/misc/unix/${PN}.c.gz ftp://us.aminet.net/pub/aminet/misc/unix/${PN}.c.gz.readme"
HOMEPAGE="ftp://us.aminet.net/pub/aminet/misc/unix/${PN}.c.gz.readme"

SLOT="0"
LICENSE="freedist"
KEYWORDS="x86 ppc sparc ~alpha"

src_unpack() {
	mkdir ${S}
	gzip -dc ${DISTDIR}/${PN}.c.gz > ${S}/unlzx.c
	cp ${DISTDIR}/${PN}.c.gz.readme  ${S}/${PN}.c.gz.readme
}

src_compile() {
	gcc ${CFLAGS} -o unlzx unlzx.c || die
}

src_install() {
	dobin unlzx
	dodoc unlzx.c.gz.readme
}
