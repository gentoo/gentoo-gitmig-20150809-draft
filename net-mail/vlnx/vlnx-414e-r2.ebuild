# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Script Revised by Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/vlnx/vlnx-414e-r2.ebuild,v 1.10 2002/11/30 20:44:09 vapier Exp $

MY_P=${PN}${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="McAfee VirusScanner for Unix/Linux(Shareware)"
SRC_URI="http://download.mcafee.com/products/evaluation/virusscan/english/unix/linux/${MY_P}.tar.Z
	 http://download.nai.com/products/datfiles/4.x/nai/dat-4153.tar"
HOMEPAGE="http://www.mcafee.com/"

SLOT="0"
LICENSE="VirusScan"
KEYWORDS="x86 sparc sparc64"

DEPEND=""
RDEPEND=""

RESTRICT="nostrip"

src_unpack() {
	cd ${WORKDIR}
	mkdir ${MY_P}
	cd ${MY_P}
	unpack vlnx414e.tar.Z
	tar -xf ${DISTDIR}/dat-4153.tar
}

src_install() {															 
	dodir /usr/bin
	insinto /opt/vlnx

	doins liblnxfv.so
	doins uvscan
	doins *.dat
	dodoc *.txt *.pdf
	doman uvscan.1
	chmod 755 ${D}/opt/vlnx/uvscan
	
	dodir /etc/env.d
	cp -f ${FILESDIR}/vlnx-${PV}-envd ${D}/etc/env.d/40vlnx
}
