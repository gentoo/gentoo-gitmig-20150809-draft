# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/ncompress/ncompress-4.2.4.ebuild,v 1.1 2001/10/09 14:28:27 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Another uncompressor for compatibility"
SRC_URI="ftp://ftp.leo.org/pub/comp/os/unix/linux/sunsite/utils/compress/${P}.tar.gz"
HOMEPAGE="http://"


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

