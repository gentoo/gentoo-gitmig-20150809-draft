# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Per Wigren <wigren@home.se>
# $Header: /var/cvsroot/gentoo-x86/app-arch/unlzx/unlzx-1.1.ebuild,v 1.1 2002/02/24 03:54:35 tod Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Unarchiver for Amiga LZX archives"

#This site is listed as the master site in NetBSD makefile
SRC_URI="ftp://us.aminet.net/pub/aminet/misc/unix/${PN}.c.gz ftp://us.aminet.net/pub/aminet/misc/unix/${PN}.c.gz.readme"

#For lack of anything better
HOMEPAGE="ftp://us.aminet.net/pub/aminet/misc/unix/${PN}.c.gz.readme"

DEPEND="virtual/glibc"

src_unpack() {
   
   mkdir ${S}
   gzip -dc ${DISTDIR}/${PN}.c.gz > ${S}/unlzx.c
   cp ${DISTDIR}/${PN}.c.gz.readme  ${S}/${PN}.c.gz.readme

}

src_compile() {
	
    gcc ${CFLAGS} -o unlzx unlzx.c

}

src_install () {

	dobin unlzx

	dodoc unlzx.c.gz.readme

}
