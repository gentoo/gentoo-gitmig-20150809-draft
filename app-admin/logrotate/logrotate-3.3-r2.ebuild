# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.3-r2.ebuild,v 1.3 2001/11/10 02:30:19 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Rotates, compresses, and mails system logs"
SRC_URI="ftp://ftp.redhat.com/redhat/linux/code/${PN}/${P}.tar.gz
	ftp://ftp.valinux.com/pub/mirrors/redhat/redhat/linux/code/${PN}/{P}.tar.gz"

DEPEND="virtual/glibc
	>=dev-libs/popt-1.5"

src_unpack() {
  unpack ${A}
}

src_compile() {
  cp Makefile Makefile.orig
  sed -e "s:CFLAGS += -g:CFLAGS += -g ${CFLAGS}:" Makefile.orig > Makefile
  try make
}

src_install() {

  insinto /usr
  dosbin logrotate
  doman logrotate.8
  dodoc examples/logrotate*

}






