# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/nbd/nbd-2.6.0.ebuild,v 1.1 2005/03/06 00:59:29 ciaranm Exp $

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sourceforge.net/"
SRC_URI="mirror://sourceforge/nbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}-2.6

src_unpack() {
	unpack ${A}
	sed -i "s:-O2:${CFLAGS}:" ${S}/gznbd/Makefile
}

src_compile() {
	econf || die
	emake || die
	emake -C gznbd || die
}

src_install() {
	dodir /usr/bin
	make install prefix=${D}/usr || die
	dobin gznbd/gznbd || die

	doman ${FILESDIR}/nbd-client.8 ${FILESDIR}/nbd-server.1
	dodoc README
}
