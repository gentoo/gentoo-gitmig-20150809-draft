# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ebuild/ebuild-1.2-r1.ebuild,v 1.2 2000/08/16 04:38:24 drobbins Exp $

P=ebuild-1.2
A=""
S=${WORKDIR}/${P}
DESCRIPTION="The heart of the ebuild-system"

src_unpack() {
  mkdir ${S}
}

src_compile() {                           
  cd ${S}
}

src_install() {                               
  cd ${O}/files
  insinto /etc
  doins make.conf
  dodir /usr/bin
  dodir /usr/sbin
  insinto /usr/bin
  insopts -m755
  doins ebuild *.sh
  insinto /usr/sbin
  doins merge.py unmerge.py
}





