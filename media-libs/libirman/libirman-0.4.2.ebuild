# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libirman/libirman-0.4.2.ebuild,v 1.2 2002/07/11 06:30:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Libirman is a library for Irman control of Unix software."
SRC_URI="http://www.lirc.org/software/snapshots/${P}.tar.gz"
HOMEPAGE="http://www.evation.com/libirman/libirman.html"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr --sysconfdir=/etc --host=${CHOST}
	assert "configure failed"
	emake || die "emake failed"
}

src_install () {
	# create include dir
	mkdir -p ${D}/usr/include
	# standard-ish make install
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		LIRC_DRIVER_DEVICE=${D}/dev/lirc \
		install
	assert "make install failed"
	# install the test programs
	dobin test_func test_io test_name
	# install extra docs
	dodoc COPYING* NEWS README* TECHNICAL TODO
}
