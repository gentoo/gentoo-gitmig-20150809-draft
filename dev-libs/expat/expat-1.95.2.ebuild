# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.2.ebuild,v 1.1 2002/03/26 03:50:25 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XML parsing libraries"
SRC_URI="http://download.sourceforge.net/expat/${P}.tar.gz"
HOMEPAGE="http://expat.sourceforge.net"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr || die

	# parallel make doesnt work
	make || die
}

src_install() {
	make prefix=${D}/usr install || die

	dodoc COPYING Changes MANIFEST README
	dohtml doc/*
}
