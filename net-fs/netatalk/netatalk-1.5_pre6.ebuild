# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/netatalk/netatalk-1.5_pre6.ebuild,v 1.1 2001/07/01 19:22:19 achim Exp $

P=netatalk-1.5pre6
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Apple-Talk"
SRC_URI="http://download.sourceforge.net/netatalk/${A}"
HOMEPAGE="http://netatakl.sourceforge.net"

DEPEND="virtual/glibc
        pam? ( sys-libs/pam-0.7 )
        tcpd? ( sys-apps/tcp-wrappers )
	ssl? ( dev-libs/openssl )
        sys-apps/shadow
        sys-devel/libtool
        sys-devel/autoconf
        sys-devel/automake
        >=sys-libs/db-3"

RDEPEND="virtual/glibc
        pam? ( sys-libs/pam-0.7 )
        sys-apps/shadow
        >=sys-libs/db-3"

src_compile() {

  local myconf
  if [ "`use pam`" ] ; then
        myconf="--with-pam"
  fi
  if [ "`use tcpd`" ] ; then
        myconf="$myconf --with-tcp-wrappers"
  fi
  if [ -z "`use ssl`" ] ; then
  	myconf="$myconf --disable-ssl"
  fi
  try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} \
      --enable-fhs $myconf

  try make

}

src_install() {                               

  try make DESTDIR=${D} install
  rm ${D}/etc/rc.d/init.d/*
  exeinto /etc/rc.d/init.d
  doexe ${FILESDIR}/atalk
  dodoc BUGS CHANGES README* COPYRIGHT VERSION 

}




