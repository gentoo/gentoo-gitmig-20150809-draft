# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mii-diag/mii-diag-2.07.ebuild,v 1.3 2003/06/21 21:19:40 drobbins Exp $

MIIVER=${PV}
LIBVER=2.04

DESCRIPTION="MII link status report and diagnostics"
HOMEPAGE="http://www.scyld.com/diag/"
# Files below are small and unversioned so I put them in the files dir
# with version suffixes.
SRC_URI="" # ftp://ftp.scyld.com/pub/diag/mii-diag.c
           # ftp://ftp.scyld.com/pub/diag/libmii.c
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~alpha"
IUSE=""
DEPEND=""

src_unpack() {
	mkdir -p ${S}
	cp ${FILESDIR}/mii-diag.c-${MIIVER} ${S}/mii-diag.c
	cp ${FILESDIR}/libmii.c-${LIBVER} ${S}/libmii.c
}

src_compile() {
	# Don't change -O below, it is a requirement for building these
	# programs.  See http://www.scyld.com/diag/#compiling
	${CC-gcc} -O -c libmii.c
	${CC-gcc} -O -DLIBMII mii-diag.c libmii.o -o mii-diag
}

src_install() {
	into /
	dosbin mii-diag
}
