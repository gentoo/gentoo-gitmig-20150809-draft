# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netstat-nat/netstat-nat-1.4.3.ebuild,v 1.7 2004/10/28 15:17:56 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="Display NAT connections"
HOMEPAGE="http://tweegy.demon.nl/projects/netstat-nat/index.html"
SRC_URI="http://tweegy.demon.nl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:CC = gcc -Wall -O2:CC = $(tc-getCC) ${CFLAGS}:" Makefile
}

src_compile() {
	emake || die "compile problem"
}

src_install() {
	dosbin netstat-nat || die
	doman netstat-nat.1
	dodoc README
}
