# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-0.7.12.ebuild,v 1.2 2001/05/01 18:29:05 achim Exp $

A="abi-${PV}.tar.gz abidistfiles.tar.gz expat.tar.gz
   unixfonts.tar.gz wv.tar.gz"
S=${WORKDIR}/abi-${PV}
DESCRIPTION="Framework for creating database applications"
SRC_URI="http://download.abisource.com/releases/${PV}/src/abi-${PV}.tar.gz
	 http://download.abisource.com/releases/${PV}/src/abidistfiles.tar.gz
	 http://download.abisource.com/releases/${PV}/src/expat.tar.gz
	 http://download.abisource.com/releases/${PV}/src/unixfonts.tar.gz
	 http://download.abisource.com/releases/${PV}/src/wv.tar.gz"

	
HOMEPAGE="http://www.gnome.org/gnome-office/abiword.shtml/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-devel/gcc-2.95.2
	>=media-libs/freetype-1.3.1
	>=media-libs/libpng-1.0.7
	>=dev-libs/glib-1.2.8
	>=x11-libs/gtk+-1.2.8
	virtual/x11"
	

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




