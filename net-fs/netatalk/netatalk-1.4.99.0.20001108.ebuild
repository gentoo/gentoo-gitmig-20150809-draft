# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/netatalk/netatalk-1.4.99.0.20001108.ebuild,v 1.1 2000/11/26 20:54:18 achim Exp $

P=netatalk-1.4.99-0.20001108
A=${P}.tar.gz
S=${WORKDIR}/${PN}
DESCRIPTION="Apple-Talk"
SRC_URI="http://download.sourceforge.net/netatalk/${A}"
HOMEPAGE="http://netatakl.sourceforge.net"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3"

src_compile() {                           
  cd ${S}
  try ./configure --prefix=/usr --host=${CHOST} \
  		--with-pam --with-shadow --with-tcp-wrappers
	
  try make	

}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  rm ${D}/etc/rc.d/init.d/*
  insinto /etc/rc.d/init.d
  doins ${FILESDIR}/atalk
  dodoc BUGS CHANGES README* COPYRIGHT VERSION 

}




