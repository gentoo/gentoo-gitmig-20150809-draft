# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam/pam-0.72-r1.ebuild,v 1.8 2000/12/24 09:55:16 achim Exp $

P=pam-0.72
A=Linux-PAM-0.72.tar.gz
S=${WORKDIR}/Linux-PAM-0.72
DESCRIPTION="PAM"
SRC_URI="http://openrock.net/pub/linux/libs/pam/pre/library/${A}"
HOMEPAGE="http://www.redhat.com/linux-info/pam/"

DEPEND=">=sys-libs/cracklib-2.7
	>=sys-libs/pwdb-0.61"

src_unpack() {                           
  unpack ${A}
  cd ${S}
  touch .freezemake
  rm default.defs
  sed -e "s/CFLAGS=.*/CFLAGS=${CFLAGS} -pipe -D_REENTRANT/" \
      -e "s:LIBDIR=.*:LIBDIR=/lib:" \
      -e "s:FAKEROOT=.*:FAKEROOT=${D}:" defs/linux.defs > default.defs
  echo "EXTRALS=-lcrypt" >> default.defs
  cp Makefile Makefile.orig
  sed -e "s/DIRS = modules libpam/DIRS = libpam modules/" Makefile.orig > Makefile
  cd modules/pam_mkhomedir
  cp Makefile Makefile.orig
  sed -e "s:-lpam:-L../../libpam -lpam:" Makefile.orig > Makefile
  
}
src_compile() {
  try make ${MAKEOPTS}
}

src_install() {                               
 cd ${S}
 touch conf/.ignore_age
 try make install
 dosbin bin/pam_conv1
 dodoc CHANGELOG Copyright README 
 docinto modules
 dodoc modules/README
 cd modules
 for i in pam_*
 do
   if [ -f $i/README ]
   then
     docinto modules/$i
     dodoc $i/README
   fi
 done
 doman doc/man/*.[38] 
 cd ${D}/usr/lib
 preplib /usr
}



