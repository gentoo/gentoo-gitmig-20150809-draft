# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/unzip/unzip-5.41-r1.ebuild,v 1.3 2000/09/15 20:08:45 drobbins Exp $

P=unzip-5.41
A=unzip541.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Unzipper for pkzip-compressed files"
SRC_URI="ftp://ftp.freesoftware.com/pub/infozip/src/${A}"
HOMEPAGE="ftp://ftp.info-zip.org/pub/infozip/UnZip.html"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  cp unix/Makefile unix/Makefile.orig
  sed -e "s:-O3:${CFLAGS}:" unix/Makefile.orig > unix/Makefile
  try make -f unix/Makefile linux
}

src_install() {                               
  cd ${S}
  into /usr
  dobin unzip funzip unzipsfx unix/zipgrep
  dodoc BUGS COPYING History* LICENSE README ToDo WHERE
}



