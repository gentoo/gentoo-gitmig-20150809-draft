# Copyright 1999-2000 Gentoo Technologies, Inc. Distributed under the terms
# of the GNU General Public License, v2 or later Author Daniel Robbins
# <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-1.3-r2.ebuild,v 1.1 2000/12/01 17:21:17 drobbins Exp $
 
A=""
S=${WORKDIR}/${P}
DESCRIPTION="Portage autobuild system"
SRC_URI=""
RDEPEND=">=sys-apps/bash-2.04
	 >=sys-devel/perl-5.6.0
	 || ( >=sys-devel/python-basic-1.5 >=dev-lang/python-1.5 )"

src_unpack() {
  mkdir ${S}
}

src_compile() {                           
  cd ${S}
}

src_install() {                               
  cd ${FILESDIR}
  insinto /etc
  doins make.conf make.defaults
  dodir /usr/lib/portage/bin
  dodir /usr/bin
  dodir /usr/sbin
  insinto /usr/bin
  insopts -m755
  doins ebuild *.sh
  insinto /usr/sbin
  doins portage-merge portage-unmerge pkgname
  insinto /usr/lib/python1.5
  doins portage.py
  exeinto /usr/lib/portage/bin
  doexe bin/* mega* portage-maintain
  dosym /usr/lib/portage/bin/pkgmerge /usr/sbin/pkgmerge
  dosym /usr/lib/portage/bin/portage-maintain /usr/sbin/portage-maintain
}




