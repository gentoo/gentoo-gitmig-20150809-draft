# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/ncompress/ncompress-4.2.4.ebuild,v 1.7 2002/09/14 15:51:24 bjb Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Another uncompressor for compatibility"
SRC_URI="ftp://ftp.leo.org/pub/comp/os/unix/linux/sunsite/utils/compress/${P}.tar.gz"
HOMEPAGE="ftp://ftp.leo.org/pub/comp/os/unix/linux/sunsite/utils/compress/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 ppc sparc sparc64 alpha"

src_compile() {
	cd ${S}
	sed -e "s:options= :options= ${CFLAGS} :" Makefile.def > Makefile
	make || die
}

src_install () {
	dobin compress 
	dosym compress /usr/bin/uncompress
	doman compress.1
}
