# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unlzx/unlzx-1.1.ebuild,v 1.17 2004/01/06 05:02:45 avenj Exp $

DESCRIPTION="Unarchiver for Amiga LZX archives"
SRC_URI="ftp://us.aminet.net/pub/aminet/misc/unix/${PN}.c.gz ftp://us.aminet.net/pub/aminet/misc/unix/${PN}.c.gz.readme"
HOMEPAGE="ftp://us.aminet.net/pub/aminet/misc/unix/${PN}.c.gz.readme"

SLOT="0"
LICENSE="freedist"
KEYWORDS="x86 ppc sparc ~alpha ~amd64"

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
