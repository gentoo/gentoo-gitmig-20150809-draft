# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cvm-vmailmgr/cvm-vmailmgr-0.3.ebuild,v 1.9 2003/12/27 00:06:06 weeve Exp $

S=${WORKDIR}/${P}
DESCRIPTION="CVM modules for use with vmailmgr"
SRC_URI="http://untroubled.org/cvm-vmailmgr/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/cvm-vmailmgr/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc "

DEPEND="virtual/glibc"

RDEPEND=">=net-mail/vmailmgr-0.96.9-r1
	>=sys-apps/ucspi-unix-0.34"

src_compile() {
	cd ${S}
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe cvm-vmailmgr cvm-vmailmgr-local cvm-vmailmgr-udp
	dodoc README ANNOUNCEMENT NEWS

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
