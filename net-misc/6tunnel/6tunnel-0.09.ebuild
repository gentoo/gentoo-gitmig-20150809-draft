# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/6tunnel/6tunnel-0.09.ebuild,v 1.6 2004/04/15 23:56:29 randy Exp $

IUSE=""
S=${WORKDIR}/${PN}
DESCRIPTION="TCP proxy for applications that don't speak IPv6"
SRC_URI="ftp://amba.bydg.pdi.net/pub/wojtekka/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 s390"
DEPEND="virtual/glibc"

#HOMEPAGE="" there is no homepage available, if you find one, please report to
#bugs.gentoo.org

src_compile() {
	sed "s/^\(CC = gcc \).*/\1$CFLAGS/" < Makefile > Makefile.new
	mv Makefile.new Makefile
	emake
}

src_install() {
	dobin 6tunnel
	doman 6tunnel.1
	dodoc README CHANGELOG
}



