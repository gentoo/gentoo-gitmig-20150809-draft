# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-1.0-r1.ebuild,v 1.1 2000/08/14 17:28:29 drobbins Exp $
 
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
  doins merge unmerge pkgname
  insinto /usr/lib/python1.5
  doins portage.py
}




