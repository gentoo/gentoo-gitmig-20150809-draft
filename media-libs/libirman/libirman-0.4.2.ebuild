# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libirman/libirman-0.4.2.ebuild,v 1.3 2002/07/22 15:42:48 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Libirman is a library for Irman control of Unix software."
SRC_URI="http://www.lirc.org/software/snapshots/${P}.tar.gz"
HOMEPAGE="http://www.evation.com/libirman/libirman.html"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install () {
	dodir /usr/include

	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		LIRC_DRIVER_DEVICE=${D}/dev/lirc \
		install || die

	dobin test_func test_io test_name
	dodoc COPYING* NEWS README* TECHNICAL TODO
}
