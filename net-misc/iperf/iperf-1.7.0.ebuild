# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/iperf/iperf-1.7.0.ebuild,v 1.8 2005/08/09 19:12:45 ranger Exp $

IUSE=""
DESCRIPTION="tool to measure IP bandwidth using UDP or TCP"
HOMEPAGE="http://dast.nlanr.net/Projects/Iperf"
SRC_URI="http://dast.nlanr.net/Projects/Iperf/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc64 x86"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:@read  INSTALL_DIR;::' Makefile || die "sed Makefile failed"
}

src_compile() {
	cd cfg
	econf || die "econf failed"
	cd ..
	emake || die "emake failed"
}

src_install() {
	make INSTALL_DIR=${D}/usr/bin install || die "make install failed"
	dodoc INSTALL README VERSION
	newinitd ${FILESDIR}/${PN}.initd ${PN}
}

pkg_postinst() {
	echo
	einfo "To run iperf in server mode, run:"
	einfo "  /etc/init.d/iperf start"
	echo
}
