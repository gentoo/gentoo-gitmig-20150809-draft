# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/etherwake/etherwake-1.09.ebuild,v 1.2 2004/03/30 12:11:25 aliz Exp $

inherit gcc

DESCRIPTION="This program generates and transmits a Wake-On-LAN (WOL) \"Magic Packet\", used for restarting machines that have been soft-powered-down (ACPI D3-warm state)."
HOMEPAGE="http://www.scyld.com/expert/wake-on-lan.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
#http://www.scyld.com/pub/diag/ether-wake.c
#http://www.scyld.com/pub/diag/etherwake.8"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~amd64"

DEPEND="virtual/glibc"

src_compile() {
	$(gcc-getCC) ${CFLAGS} -o etherwake ether-wake.c || die "Compile failed"
}

src_install() {
	dobin etherwake || die
	doman etherwake.8
}
