# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/mtools/mtools-3.9.8-r1.ebuild,v 1.9 2002/07/17 20:43:17 drobbins Exp $



S=${WORKDIR}/${P}
DESCRIPTION="Mtools is a collection of utilities to access MS-DOS disks 
from Unix without mounting them. It supports Win95 style long file names,..." 

SRC_URI="http://mtools.linux.lu/mtools-3.9.8.tar.gz"
SLOT="0"
HOMEPAGE="http://mtools.linux.lu"
DEPEND="virtual/glibc sys-apps/texinfo"
RDEPEND="virtual/glibc"
LICENSE="GPL-2"

src_compile() {
  try ./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info \
  	--sysconfdir=/etc/mtools
  try make
}

src_install () {
  try make prefix=${D}/usr mandir=${D}/usr/share/man \
  	infodir=${D}/usr/share/info sysconfdir=${D}/etc/mtools install
  insinto /etc/mtools
  newins mtools.conf mtools.conf.example
  dodoc COPYING ChangeLog NEWPARAMS README* Release.notes 
}

