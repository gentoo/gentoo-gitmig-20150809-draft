# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netpipe/netpipe-1.0.0_beta2.ebuild,v 1.7 2004/10/26 14:24:39 vapier Exp $

DESCRIPTION="tool to reliably distribute binary data using UDP broadcasting techniques"
HOMEPAGE="http://home.t-online.de/home/gerd.o/netpipe.html"
SRC_URI="http://home.t-online.de/home/gerd.o/netpipe.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/netpipe"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:^OPT=.*:OPT = ${CFLAGS}:" \
		-e "s:^#CC.*:CC = $(tc-getCC):" \
		Makefile
}

src_compile() {
	make || die
}

src_install() {
	dobin netpipe || die
	dodoc DOCUMENTATION INSTALL TECH-NOTES
}
