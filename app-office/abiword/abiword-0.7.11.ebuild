# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-0.7.11.ebuild,v 1.1 2000/09/19 00:56:17 achim Exp $

A="abi-${PV}.tar.gz abidistfiles-${PV}.tar.gz expat-${PV}.tar.gz 
   unixfonts-${PV}.tar.gz wv-${PV}.tar.gz"
S=${WORKDIR}/abi-0.7.11
DESCRIPTION="Framework for creating database applications"
SRC_URI="http://download.abisource.com/releases/${PV}/src/lf/abi-${PV}.tar.gz
	 http://download.abisource.com/releases/${PV}/src/lf/abidistfiles-${PV}.tar.gz 
	 http://download.abisource.com/releases/${PV}/src/lf/expat-${PV}.tar.gz 
	 http://download.abisource.com/releases/${PV}/src/lf/unixfonts-${PV}.tar.gz 
	 http://download.abisource.com/releases/${PV}/src/lf/wv-${PV}.tar.gz"

	
HOMEPAGE="http://www.gnome.org/gnome-office/abiword.shtml/"

src_unpack() {
  unpack ${A}
  cd ${S}
}

src_compile() {                           
  cd ${S}
  try make prefix=/opt/gnome/ UNIX_CAN_BUILD_STATIC=0
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome  UNIX_CAN_BUILD_STATIC=0 install
  cp ${D}/opt/gnome/AbiSuite/bin/AbiWord AbiWord.orig
  sed -e "s:${D}::" AbiWord.orig > ${D}/opt/gnome/AbiSuite/bin/AbiWord
  cd ${D}/opt/gnome/bin
  rm -f abiword
  rm -f AbiWord
  ln -s  ../AbiSuite/bin/AbiWord AbiWord
  ln -s  ../AbiSuite/bin/AbiWord abiword
}




