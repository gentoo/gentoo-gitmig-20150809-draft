# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam/pam-0.73-r1.ebuild,v 1.2 2001/02/07 21:04:43 achim Exp $

P=pam-${PV}
A=Linux-PAM-${PV}.tar.gz
S=${WORKDIR}/Linux-PAM-${PV}
DESCRIPTION="PAM"
SRC_URI="http://www.kernel.org/pub/linux/libs/pam/pre/library/${A}"
HOMEPAGE="http://www.redhat.com/linux-info/pam/"

DEPEND=">=sys-libs/cracklib-2.7-r2
	>=sys-libs/pwdb-0.61-r3
        berkdb? ( =sys-libs/db-1.85-r1 )"

src_compile() {

  try ./configure --prefix= --host=${CHOST} \
	--sbindir=/usr/sbin --mandir=/usr/share/man \
	--enable-fakeroot=${D} \
	--enable-read-both-confs


  cp Makefile Makefile.orig
  sed -e "s:libpam_misc doc examples:libpam_misc doc:" \
	Makefile.orig > Makefile

  cp Make.Rules Make.orig
  sed -e "s:/usr/bin/install:/bin/install:" \
      -e "s:-Wpointer-arith::" \
      -e "s:^CFLAGS=:CFLAGS=${CFLAGS} :" Make.orig > Make.Rules

  if [ -z "`use berkdb`" ]
  then
    cp Make.Rules Make.orig
    sed -e "s:^HAVE_LIBNDBM=yes:HAVE_LIBNDBM=no:" Make.orig > Make.Rules
  fi

  try make

}

src_install() {

 try make install MANDIR=\"/usr/share/man\"
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

 dosym libpam.so.0.73 /lib/libpam.so
 dosym libpamc.so.0.73 /lib/libpamc.so
 dosym libpam_misc.so.0.73 /lib/libpam_misc.so
 dosym libpam.so.0.73 /lib/libpam.so.0
 dosym libpamc.so.0.73 /lib/libpamc.so.0
 dosym libpam_misc.so.0.73 /lib/libpam_misc.so.0

}



