# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-0.7.14.ebuild,v 1.1 2001/06/04 10:34:15 achim Exp $

A="abi-${PV}.tar.gz abidistfiles-${PV}.tar.gz expat-${PV}.tar.gz
   unixfonts-${PV}.tar.gz wv-${PV}.tar.gz"
S=${WORKDIR}/abi-${PV}
DESCRIPTION="Framework for creating database applications"
SRC_URI="http://www.abisource.com/downloads/Version-${PV}/abi-${PV}.tar.gz
	 http://www.abisource.com/downloads/Version-${PV}/abidistfiles-${PV}.tar.gz
	 http://www.abisource.com/downloads/Version-${PV}/expat-${PV}.tar.gz
	 http://www.abisource.com/downloads/Version-${PV}/expat-${PV}.tar.gz
	 http://www.abisource.com/downloads/Version-${PV}/psiconv-${PV}.tar.gz
	 http://www.abisource.com/downloads/Version-${PV}/unixfonts-${PV}.tar.gz
	 http://www.abisource.com/downloads/Version-${PV}/wv-${PV}.tar.gz"

	
HOMEPAGE="http://www.gnome.org/gnome-office/abiword.shtml/"

DEPEND="virtual/glibc
	>=sys-devel/gcc-2.95.2
	=media-libs/freetype-1.3.1-r2
	>=media-libs/libpng-1.0.7
	>=x11-libs/gtk+-1.2.8
	virtual/x11"
	

src_compile() {                           
  try make prefix=/opt/gnome/ UNIX_CAN_BUILD_STATIC=0
}

src_install() {
  try make prefix=${D}/opt/gnome  UNIX_CAN_BUILD_STATIC=0 install
  cp ${D}/opt/gnome/AbiSuite/bin/AbiWord AbiWord.orig
  sed -e "s:${D}::" AbiWord.orig > ${D}/opt/gnome/AbiSuite/bin/AbiWord
  cd ${D}/opt/gnome/bin
  rm -f abiword
  rm -f AbiWord
  ln -s  ../AbiSuite/bin/AbiWord AbiWord
  ln -s  ../AbiSuite/bin/AbiWord abiword
}




