# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/iperf/iperf-1.7.0.ebuild,v 1.2 2003/09/05 22:13:37 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Iperf is a tool to measure IP bandwidth using UDP or TCP. It allows for tuning various parameters, and reports bandwidth, delay jitter, and packet loss. It supports IPv6 and multicast."
SRC_URI="http://dast.nlanr.net/Projects/Iperf/${P}-source.tar.gz"
HOMEPAGE="http://dast.nlanr.net/Projects/Iperf"
DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

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

src_install () {
	make INSTALL_DIR=${D}/usr/bin install || die
	dodoc INSTALL README VERSION
}
