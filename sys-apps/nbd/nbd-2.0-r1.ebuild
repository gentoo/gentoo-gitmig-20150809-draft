# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nbd/nbd-2.0-r1.ebuild,v 1.5 2004/06/30 02:53:07 vapier Exp $

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sourceforge.net/"
SRC_URI="mirror://sourceforge/nbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die
	make || die
	make -C gznbd || die
}

src_install() {
	dodir /usr/bin
	make install prefix=${D}/usr || die
	dobin gznbd/gznbd || die

	doman ${FILESDIR}/nbd-client.8 ${FILESDIR}/nbd-server.1
	dodoc README
}
