# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libPropList/libPropList-0.10.1-r2.ebuild,v 1.6 2002/07/16 03:26:36 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libPropList"
SRC_URI="ftp://ftp.windowmaker.org/pub/release/srcs/current/${P}.tar.gz"
HOMEPAGE="http://www.windowmaker.org/"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"

src_compile() {													 

	./configure --host=${CHOST} --prefix=/usr || die
	make || die

}

src_install() {															 

	make prefix=${D}/usr install || die

	dodoc AUTHORS COPYING* ChangeLog README TODO

}
