# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nbd/nbd-2.0.ebuild,v 1.2 2003/06/21 21:19:40 drobbins Exp $

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sf.net"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

KEYWORDS="x86 amd64 -ppc"
SLOT="0"

S=${WORKDIR}/${PN}
SRC_URI="mirror://sourceforge/nbd/${P}.tar.gz"

src_compile() {
	econf
	make || die
	make -C gznbd || die
}

src_install() {
	dobin nbd-client nbd-server gznbd/gznbd
	dodoc README
}
