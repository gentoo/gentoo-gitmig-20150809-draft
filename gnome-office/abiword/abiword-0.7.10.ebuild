# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-office/abiword/abiword-0.7.10.ebuild,v 1.3 2000/09/15 20:08:57 drobbins Exp $

P=abiword-0.7.10
A="abi-0.7.10.tar.gz abidistfiles-0.7.10.tar.gz expat-0.7.10.tar.gz 
   unixfonts-0.7.10.tar.gz wv-0.7.10.tar.gz"
S=${WORKDIR}/abi-0.7.10
DESCRIPTION="Framework for creating database applications"
SRC_URI="http://download.abisource.com/releases/0.7.10/src/lf/abi-0.7.10.tar.gz
	 http://download.abisource.com/releases/0.7.10/src/lf/abidistfiles-0.7.10.tar.gz 
	 http://download.abisource.com/releases/0.7.10/src/lf/expat-0.7.10.tar.gz 
	 http://download.abisource.com/releases/0.7.10/src/lf/unixfonts-0.7.10.tar.gz 
	 http://download.abisource.com/releases/0.7.10/src/lf/wv-0.7.10.tar.gz"

	
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
}




