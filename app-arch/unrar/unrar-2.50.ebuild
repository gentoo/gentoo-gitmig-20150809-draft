# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar/unrar-2.50.ebuild,v 1.8 2002/07/17 20:44:57 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Uncompress rar files"
SRC_URI="ftp://ftp.elf.stuba.sk/pub/pc/pack/unrar250.zip"
SLOT="0"
HOMEPAGE="ftp://ftp.elf.stuba.sk/pub/pc/pack"
LICENSE="unRAR"

DEPEND="virtual/glibc app-arch/unzip"
RDEPEND="virtual/glibc"
# Might be more depends... probably not, though

src_compile() {
# Many many warnings... but seems to work okay  
  cd src
  mv Makefile Makefile.orig
  sed -e "s:-O2:${CFLAGS}:" -e "s:-Wall::" Makefile.orig > Makefile
  try make
}

src_install() {
  dobin src/unrar
  dodoc readme.txt license.txt
}



