# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mii-diag/mii-diag-2.09.ebuild,v 1.2 2004/04/27 21:17:16 agriffis Exp $

inherit eutils

MIIVER=${PV}
LIBVER=2.10

DESCRIPTION="MII link status report and diagnostics"
HOMEPAGE="http://www.scyld.com/diag/"
# Files below are small and unversioned so I put them in the files dir
# with version suffixes.
SRC_URI=""	# ftp://ftp.scyld.com/pub/diag/mii-diag.c
			# ftp://ftp.scyld.com/pub/diag/libmii.c
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha"
IUSE=""
DEPEND=""

src_unpack() {
	mkdir -p ${S} || die
	cd ${S} || die
	cp ${FILESDIR}/mii-diag.c-${MIIVER} mii-diag.c || die
	cp ${FILESDIR}/libmii.c-${LIBVER} libmii.c     || die
	epatch ${FILESDIR}/mii-diag.c-2.09-gcc33.patch # epatch contains die
}

src_compile() {
	# Don't change -O below, it is a requirement for building these
	# programs.  See http://www.scyld.com/diag/#compiling
	${CC-gcc} -O -c libmii.c || die
	${CC-gcc} -O -DLIBMII mii-diag.c libmii.o -o mii-diag || die
}

src_install() {
	into /; dosbin mii-diag || die
}
