# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libol/libol-0.2.23.ebuild,v 1.5 2001/11/10 12:05:20 hallski Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Support library for syslog-ng"
SRC_URI="http://www.balabit.hu/downloads/libol/0.2/${P}.tar.gz"
HOMEPAGE="http://www.balabit.hu/en/products/syslog-ng/"

#DEPEND=">="

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --enable-shared					\
		    --enable-static					\
		    --disable-libtool-lock
	assert

	make CFLAGS="${CFLAGS}" ${MAKEOPTS} prefix=${D}/usr all || die
}

src_install() {
	make prefix=${D}/usr install || die

	dodoc ChangeLog 
}
