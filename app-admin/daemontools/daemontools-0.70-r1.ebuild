# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/daemontools/daemontools-0.70-r1.ebuild,v 1.4 2000/11/01 04:44:10 achim Exp $

P=daemontools-0.70
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Collection of tools for managing UNIX services"
SRC_URI="http://cr.yp.to/daemontools/"${A}
HOMEPAGE="http://cr.yp.to/daemontools.html"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp conf-cc conf-cc.orig
  sed -e "s:-O2:${CFLAGS}:" conf-cc.orig > conf-cc
}

src_compile() {                           
  cd ${S}
  try make
}

src_install() {                               
  cd ${S}
  into /usr
  for i in svscan supervise svc svok svstat fghack multilog tai64n \
	   tai64nlocal softlimit setuidgid envuidgid envdir setlock
  do
    dobin $i
  done
  dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
}



