# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libPropList/libPropList-0.10.1-r2.ebuild,v 1.12 2004/06/24 22:05:15 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libPropList"
SRC_URI="ftp://ftp.windowmaker.org/pub/release/srcs/current/${P}.tar.gz"
HOMEPAGE="http://www.windowmaker.org/"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc "

DEPEND="virtual/glibc"

src_compile() {

	./configure --host=${CHOST} --prefix=/usr || die
	make || die

}

src_install() {

	make prefix=${D}/usr install || die

	dodoc AUTHORS COPYING* ChangeLog README TODO

}
