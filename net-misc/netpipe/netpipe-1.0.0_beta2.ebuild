# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netpipe/netpipe-1.0.0_beta2.ebuild,v 1.6 2004/09/03 14:00:54 dholm Exp $

IUSE=""

DESCRIPTION="tool to reliably distribute binary data using UDP broadcasting techniques"

SRC_URI="http://home.t-online.de/home/gerd.o/netpipe.tar.gz"
HOMEPAGE="http://home.t-online.de/home/gerd.o/netpipe.html"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

S="${WORKDIR}/netpipe"

src_unpack() {
	unpack ${A} ; cd ${S}
	mv Makefile Makefile.orig
	sed -e "s:^OPT=.*:OPT = ${CFLAGS}:" \
				-e "s:^#CC.*:CC = gcc:" \
				Makefile.orig > Makefile
}

src_compile() {
	make || die
}

src_install () {
	dobin netpipe
	dodoc DOCUMENTATION INSTALL TECH-NOTES
}
