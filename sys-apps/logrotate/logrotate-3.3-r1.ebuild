# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/logrotate/logrotate-3.3-r1.ebuild,v 1.1 2000/08/02 17:07:13 achim Exp $

P=logrotate-3.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="sys-apps"
DESCRIPTION="Rotates, compresses, and mails system logs"
SRC_URI="ftp://ftp.redhat.com/redhat/code/logrotate/"${A}

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s:CFLAGS += -g:CFLAGS += -g ${CFLAGS}:" Makefile.orig > Makefile
  make
}

src_install() {                               
  cd ${S}
  insinto /usr
  dosbin logrotate
  doman logrotate.8
  dodoc examples/logrotate*
}




