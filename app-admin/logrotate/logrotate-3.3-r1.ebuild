# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.3-r1.ebuild,v 1.2 2000/11/01 04:44:10 achim Exp $

P=logrotate-3.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Rotates, compresses, and mails system logs"
SRC_URI="ftp://ftp.redhat.com/redhat/code/logrotate/${A}
	ftp://ftp.valinux.com/pub/mirrors/redhat/redhat/code/logrotate/${A}"

DEPEND=">=sys-libs/glibc-2.1.3
	>=app-arch/rpm-3.0.5"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s:CFLAGS += -g:CFLAGS += -g ${CFLAGS}:" Makefile.orig > Makefile
  try make
}

src_install() {                               
  cd ${S}
  insinto /usr
  dosbin logrotate
  doman logrotate.8
  dodoc examples/logrotate*
}






