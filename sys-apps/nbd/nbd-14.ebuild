# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nbd/nbd-14.ebuild,v 1.3 2002/07/11 06:30:55 drobbins Exp $

MY_PP=${P//-/.}
S=${WORKDIR}/${PN}
DESCRIPTION="Userland client/server for kernel network block device"
SRC_URI="http://atrey.karlin.mff.cuni.cz/~pavel/nbd/${MY_P}.tar.gz"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~pavel/nbd/nbd.html"

DEPEND=">=sys-devel/gcc-2.95.3
	>=sys-devel/make-3.79.1"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	mkdir -p ${D}/usr/bin
	make \
		prefix=${D}/usr \
		install || die "make install failed"
}
