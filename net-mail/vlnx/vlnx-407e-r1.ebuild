# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/vlnx/vlnx-407e-r1.ebuild,v 1.1 2000/08/16 17:16:16 achim Exp $

P=vlnx407e
A="${P}.tar.Z dat-4089.tar"

S=${WORKDIR}/${P}
DESCRIPTION="Mc Afee VirusScanner (Shareware)"
SRC_URI="http://download.mcafee.com/products/evaluation/virusscan/english/unix/linux/vlnx407e.tar.Z
	 http://download.nai.com/products/datfiles/4.x/nai/dat-4089.tar"

src_unpack() {
  cd ${WORKDIR}
  mkdir ${P}
  cd ${P}
  unpack vlnx407e.tar.Z
  tar -xf ${DISTDIR}/dat-4079.tar
}

src_compile() {                           
  cd ${S}
}

src_install() {                               
  cd ${S}
  dodir /usr/bin
  insinto /usr/share/vscan
  insopts -m 755
  doins uvscan
  dosym /usr/share/vscan/uvscan /usr/bin/uvscan
  insopts -m 644
  doins *.dat
  dodoc *.txt *.pdf
}



