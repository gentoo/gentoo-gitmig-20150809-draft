# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/zip/zip-2.3.ebuild,v 1.1 2000/10/14 11:15:26 achim Exp $

A=zip23.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Info ZIP"
SRC_URI="ftp://ftp.info-zip.org/pub/infozip/src/${A}"
HOMEPAGE="ftp://ftp.freesoftware.com/pub/infozip/Zip.html"


src_unpack() {
  unpack ${A}
  cd ${S}/unix
  cp Makefile Makefile.orig
  sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
}
src_compile() {

    cd ${S}
    try make -f unix/Makefile generic_gcc

}

src_install () {

    cd ${S}
    into /usr
    dobin zip zipcloak zipnote zipsplit
    doman man/zip.1
 
    dodoc BUGS CHANGES LICENSE MANUAL README TODO WHATSNEW WHERE

}

