# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mii-diag/mii-diag-2.09.ebuild,v 1.4 2004/11/05 01:25:25 vapier Exp $

inherit eutils toolchain-funcs

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
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_unpack() {
	cp ${FILESDIR}/mii-diag.c-${MIIVER} mii-diag.c || die "mii-diag.c"
	cp ${FILESDIR}/libmii.c-${LIBVER} libmii.c || die "libmii.c"
	epatch ${FILESDIR}/mii-diag.c-${PV}-gcc33.patch
}

src_compile() {
	# Don't change -O below, it is a requirement for building these
	# programs.  See http://www.scyld.com/diag/#compiling
	$(tc-getCC) -O -c libmii.c || die
	$(tc-getCC) -O -DLIBMII mii-diag.c libmii.o -o mii-diag || die
}

src_install() {
	into /
	dosbin mii-diag || die
}
