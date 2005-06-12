# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mii-diag/mii-diag-2.11.ebuild,v 1.1 2005/06/12 20:34:36 vapier Exp $

inherit toolchain-funcs

MIIVER=${PV}
LIBVER=2.11

DESCRIPTION="MII link status report and diagnostics"
HOMEPAGE="http://www.scyld.com/ethercard_diag.html"
# Files below are small and unversioned so I put them in the files dir
# with version suffixes.
SRC_URI=""	# ftp://ftp.scyld.com/pub/diag/mii-diag.c
			# ftp://ftp.scyld.com/pub/diag/libmii.c

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_unpack() {
	cp "${FILESDIR}"/mii-diag.c-${MIIVER} mii-diag.c || die "mii-diag.c"
	cp "${FILESDIR}"/mii-diag.8-${MIIVER} mii-diag.8 || die "mii-diag.8"
	cp "${FILESDIR}"/libmii.c-${LIBVER} libmii.c || die "libmii.c"
}

src_compile() {
	# Don't change -O below, it is a requirement for building these
	# programs.  See http://www.scyld.com/ethercard_diag.html#compiling
	$(tc-getCC) -O ${LDFLAGS} -c libmii.c || die
	$(tc-getCC) -O ${LDFLAGS} -DLIBMII mii-diag.c libmii.o -o mii-diag || die
}

src_install() {
	into /
	dosbin mii-diag || die
	doman mii-diag.8
}
