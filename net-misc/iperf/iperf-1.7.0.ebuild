# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/iperf/iperf-1.7.0.ebuild,v 1.3 2004/04/19 06:42:07 vapier Exp $

DESCRIPTION="tool to measure IP bandwidth using UDP or TCP"
HOMEPAGE="http://dast.nlanr.net/Projects/Iperf"
SRC_URI="http://dast.nlanr.net/Projects/Iperf/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:@read  INSTALL_DIR;::' Makefile
}

src_compile() {
	cd cfg
	econf || die
	cd ..
	emake || die
}

src_install() {
	make INSTALL_DIR=${D}/usr/bin install || die
	dodoc INSTALL README VERSION
}
