# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cvm-vmailmgr/cvm-vmailmgr-0.6.ebuild,v 1.1 2004/01/06 00:16:06 robbat2 Exp $

inherit fixheadtails
S=${WORKDIR}/${P}
DESCRIPTION="CVM modules for use with vmailmgr"
SRC_URI="http://untroubled.org/cvm-vmailmgr/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/cvm-vmailmgr/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/glibc
		net-libs/cvm
		>=dev-libs/bglibs-1.009"

RDEPEND=">=net-mail/vmailmgr-0.96.9-r1
		 >=sys-apps/ucspi-unix-0.34
		 net-libs/cvm
		 virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	ht_fix_file Makefile
	sed 's|-lcvm/|-lcvm-|g' -i Makefile
}


src_compile() {
	cd ${S}
	echo "/usr/lib/bglibs/include" > conf-bgincs
	echo "/usr/lib/bglibs/lib" > conf-bglibs
	echo "${CC} ${CFLAGS}" > conf-cc
	echo "${CC} -s" > conf-ld
	make || die
}

src_install () {
	exeinto /usr/bin
	doexe cvm-vmailmgr cvm-vmailmgr-local cvm-vmailmgr-udp cvm-vmlookup

	exeinto /var/lib/supervise/cvm-vmailmgr
	newexe ${FILESDIR}/run-cvm-vmailmgr run

	exeinto /var/lib/supervise/cvm-vmailmgr/log
	newexe ${FILESDIR}/run-cvm-vmailmgr-log run

	insinto /etc/vmailmgr
	doins ${FILESDIR}/cvm-vmailmgr-socket

	dodoc ANNOUNCEMENT COPYING FILES NEWS README TARGETS TODO VERSION
}

pkg_postinst() {
	einfo "To start cvm-vmailmgr you need to link"
	einfo "/var/lib/supervise/cvm-vmailmgr to /service"
}
