# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipsc/ipsc-0.4.3.2-r1.ebuild,v 1.1 2008/10/11 23:07:47 chainsaw Exp $

inherit toolchain-funcs

DESCRIPTION="IP Subnet Calculator"
HOMEPAGE="http://packages.debian.org/unstable/net/ipsc"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:^CC = gcc:CC = $(tc-getCC):" src/Makefile || die "Unable to override compiler selection"
	sed -i -e "s:^CFLAGS = .*::" src/Makefile || die "Unable to unset upstream CFLAGS"
}

src_compile() {
	cd src
	emake || die "Compilation failed"
}

src_install() {
	dodoc README ChangeLog TODO CONTRIBUTORS
	dobin src/ipsc
	doman src/ipsc.1
}
