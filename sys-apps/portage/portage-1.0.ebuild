# Copyright 1999-2000 Gentoo Technologies, Inc.
# Author Daniel Robbins <drobbins@gentoo.org>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-1.0.ebuild,v 1.2 2000/07/31 03:03:20 drobbins Exp $
 
P=portage-1.0
A=""
S=${WORKDIR}/${P}
CATEGORY="sys"
DESCRIPTION="Portage autobuild system"

src_unpack() {
  mkdir ${S}
}

src_compile() {                           
  cd ${S}
}

src_install() {                               
  cd ${FILESDIR}
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




