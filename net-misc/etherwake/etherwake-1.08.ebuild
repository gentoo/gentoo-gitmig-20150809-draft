# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/etherwake/etherwake-1.08.ebuild,v 1.7 2003/12/22 16:58:25 zul Exp $

DESCRIPTION="This program generates and transmits a Wake-On-LAN (WOL) \"Magic Packet\", used for restarting machines that have been soft-powered-down (ACPI D3-warm state)."
SRC_URI="http://www.scyld.com/pub/diag/ether-wake.c
		http://www.scyld.com/pub/diag/etherwake.8"
HOMEPAGE="http://www.scyld.com/expert/wake-on-lan.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc"

src_unpack() {
	mkdir -p ${S}
	cp ${DISTDIR}/ether-wake.c ${S}/etherwake.c
}

src_compile() {
	cd ${S}
	gcc ${CFLAGS} -o etherwake etherwake.c || die "Compile failed"
}

src_install() {
	dosbin etherwake
	doman ${DISTDIR}/etherwake.8
	dodoc ${FILESDIR}/readme
}
