# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/unzip/unzip-5.42-r1.ebuild,v 1.5 2002/07/17 20:44:57 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Unzipper for pkzip-compressed files"
SRC_URI="http://soft.ivanovo.ru/Linux/unzip542.tar.gz"
SLOT="0"

HOMEPAGE="ftp://ftp.info-zip.org/pub/infozip/UnZip.html"
LICENSE="Info-ZIP"

DEPEND="virtual/glibc"
KEYWORDS="x86 ppc"

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



