# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/unzip/unzip-5.42.ebuild,v 1.2 2001/08/02 20:10:36 danarmak Exp $

A=unzip542.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Unzipper for pkzip-compressed files"
#SRC_URI="ftp://ftp.freesoftware.com/pub/infozip/src/${A}"
SRC_URI="http://soft.ivanovo.ru/Linux/${A}"
#         http://mirrors.rcn.com/pub/OpenBSD/distfiles/${A}"

HOMEPAGE="ftp://ftp.info-zip.org/pub/infozip/UnZip.html"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILEDIR}/unzip-5.42.patch
}


src_compile() {

  cp unix/Makefile unix/Makefile.orig
  sed -e "s:-O3:${CFLAGS}:" unix/Makefile.orig > unix/Makefile

  try make -f unix/Makefile linux

}

src_install() {

  dobin unzip funzip unzipsfx unix/zipgrep
  doman man/*.1
  dodoc BUGS COPYING History* LICENSE README ToDo WHERE


}



