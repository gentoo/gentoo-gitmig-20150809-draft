# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libirman/libirman-0.4.2.ebuild,v 1.9 2004/02/17 20:05:31 agriffis Exp $

DESCRIPTION="library for Irman control of Unix software"
SRC_URI="http://www.lirc.org/software/snapshots/${P}.tar.gz"
HOMEPAGE="http://www.evation.com/libirman/libirman.html"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 sparc alpha ia64"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	dodir /usr/include

	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		LIRC_DRIVER_DEVICE=${D}/dev/lirc \
		install || die

	dobin test_func test_io test_name
	dodoc COPYING* NEWS README* TECHNICAL TODO
}
