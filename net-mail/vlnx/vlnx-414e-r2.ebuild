# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Script Revised by Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/vlnx/vlnx-414e-r2.ebuild,v 1.5 2002/08/14 12:05:25 murphy Exp $

MY_P=${PN}${PV}

S=${WORKDIR}/${MY_P}
DESCRIPTION="McAfee VirusScanner for Unix/Linux(Shareware)"
SRC_URI="http://download.mcafee.com/products/evaluation/virusscan/english/unix/linux/${MY_P}.tar.Z
	 http://download.nai.com/products/datfiles/4.x/nai/dat-4153.tar"

SLOT="0"
LICENSE="VirusScan"
KEYWORDS="x86 sparc sparc64"

DEPEND=""
RDEPEND="sys-devel/ld.so"
src_unpack() {
	cd ${WORKDIR}
	mkdir ${MY_P}
	cd ${MY_P}
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
