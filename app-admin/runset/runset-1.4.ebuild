# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/runset/runset-1.4.ebuild,v 1.6 2002/07/20 00:45:17 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Runset Init suite, a replacement for sysv style initd"
SRC_URI="ftp://ftp.ocis.net/pub/users/ldeutsch/release/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc"


src_compile() {

  try ./configure --host=${CHOST} --prefix=/usr --infodir=/usr/share/info
  try make
}

src_install() {

  # fix info file
  echo "INFO-DIR-SECTION Admin" >>doc/runset.info
  echo "START-INFO-DIR-ENTRY" >>doc/runset.info
  echo "* runset: (runset). " >>doc/runset.info
  echo "END-INFO-DIR-ENTRY" >>doc/runset.info

  try make DESTDIR=${D} install
  dodoc AUTHORS COPYING INSTALL ChangeLog LSM NEWS README
  cp -a ${S}/sample ${D}/usr/share/doc/${PF}
 
}





