# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# Script Revised by Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/vlnx/vlnx-414e-r2.ebuild,v 1.1 2002/03/19 05:08:29 chadh Exp $

P=vlnx414e
A="${P}.tar.Z dat-4153.tar"

S=${WORKDIR}/${P}
DESCRIPTION="McAfee VirusScanner for Unix/Linux(Shareware)"
SRC_URI="http://download.mcafee.com/products/evaluation/virusscan/english/unix/linux/vlnx414e.tar.Z
	 http://download.nai.com/products/datfiles/4.x/nai/dat-4153.tar"

DEPEND=""
RDEPEND="sys-devel/ld.so"
src_unpack() {
  cd ${WORKDIR}
  mkdir ${P}
  cd ${P}
  unpack vlnx414e.tar.Z
  tar -xf ${DISTDIR}/dat-4153.tar
}

src_install() {                               
  dodir /usr/bin
  insinto /usr/lib
  insopts -m 555
  doins liblnxfv.so
  insinto /usr/share/vscan
  insopts -m 755
  doins uvscan
  insopts -m 444
  doins *.dat
  dodoc *.txt *.pdf

  dosym /usr/share/vscan/uvscan /usr/bin/uvscan
  doman uvscan.1
}



