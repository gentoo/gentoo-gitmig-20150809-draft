# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam/pam-0.73.ebuild,v 1.3 2001/01/31 20:49:07 achim Exp $

P=pam-${PV}
A=Linux-PAM-${PV}.tar.gz
S=${WORKDIR}/Linux-PAM-${PV}
DESCRIPTION="PAM"
SRC_URI="http://www.kernel.org/pub/linux/libs/pam/pre/library/${A}"
HOMEPAGE="http://www.redhat.com/linux-info/pam/"

DEPEND=">=sys-libs/cracklib-2.7
	>=sys-libs/pwdb-0.61"

src_unpack() {                           
  unpack ${A}
  cd ${S}
#  touch .freezemake
  cd modules/pam_userdb
  cp pam_userdb.c pam_userdb.orig
  sed -e "s:<ndbm\.h>:<db1/ndbm.h>:" pam_userdb.orig > pam_userdb.c
  
}
src_compile() {
  try ./configure --prefix= --host=${CHOST} \
	--sbindir=/usr/sbin \
	--enable-fakeroot=${D} \
	--enable-read-both-confs
 # try make ${MAKEOPTS}
  cp Makefile Makefile.orig
  sed -e "s:libpam_misc doc examples:libpam_misc doc:" \
	Makefile.orig > Makefile
  try make
}

src_install() {                               
 cd ${S}
 try make install
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
 dosym libpam.so.0.73 /lib/libpam.so
 dosym libpamc.so.0.73 /lib/libpamc.so
 dosym libpam_misc.so.0.73 /lib/libpam_misc.so
 dosym libpam.so.0.73 /lib/libpam.so.0
 dosym libpamc.so.0.73 /lib/libpamc.so.0
 dosym libpam_misc.so.0.73 /lib/libpam_misc.so.0
}



