# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cvm-vmailmgr/cvm-vmailmgr-0.4.ebuild,v 1.4 2004/06/19 05:58:26 vapier Exp $

inherit gcc

DESCRIPTION="CVM modules for use with vmailmgr"
HOMEPAGE="http://untroubled.org/cvm-vmailmgr/"
SRC_URI="http://untroubled.org/cvm-vmailmgr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

DEPEND="virtual/glibc
	>=dev-libs/bglibs-1.009"
RDEPEND=">=net-mail/vmailmgr-0.96.9-r1
	>=sys-apps/ucspi-unix-0.34"

src_compile() {
	echo "/usr/lib/bglibs/include" > conf-bgincs
	echo "/usr/lib/bglibs/lib" > conf-bglibs
	echo "$(gcc-getCC) ${CFLAGS}" > conf-cc
	make || die
}

src_install () {
	dobin cvm-vmailmgr cvm-vmailmgr-local cvm-vmailmgr-udp || die

	exeinto /var/lib/supervise/cvm-vmailmgr
	newexe ${FILESDIR}/run-cvm-vmailmgr run

	exeinto /var/lib/supervise/cvm-vmailmgr/log
	newexe ${FILESDIR}/run-cvm-vmailmgr-log run

	insinto /etc/vmailmgr
	doins ${FILESDIR}/cvm-vmailmgr-socket

	dodoc ANNOUNCEMENT FILES NEWS README TARGETS TODO VERSION
}

pkg_postinst() {
	einfo "To start cvm-vmailmgr you need to link"
	einfo "/var/lib/supervise/cvm-vmailmgr to /service"
}
