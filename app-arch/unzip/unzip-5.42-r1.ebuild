# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/unzip/unzip-5.42-r1.ebuild,v 1.1 2002/04/19 23:17:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Unzipper for pkzip-compressed files"
SRC_URI="http://soft.ivanovo.ru/Linux/unzip542.tar.gz"

HOMEPAGE="ftp://ftp.info-zip.org/pub/infozip/UnZip.html"

DEPEND="virtual/glibc"


src_compile() {

  cp unix/Makefile unix/Makefile.orig
  sed -e "s:-O3:${CFLAGS}:" unix/Makefile.orig > unix/Makefile

  case $ARCH in
  	i?.86)		TARGET=linux		;;
	    *)		TARGET=linux_noasm	;;
  esac

  try make -f unix/Makefile $TARGET

}

src_install() {

  dobin unzip funzip unzipsfx unix/zipgrep
  doman man/*.1
  dodoc BUGS COPYING History* LICENSE README ToDo WHERE


}



