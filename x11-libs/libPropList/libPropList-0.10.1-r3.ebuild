# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libPropList/libPropList-0.10.1-r3.ebuild,v 1.8 2004/01/04 17:46:57 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libPropList"
SRC_URI="ftp://ftp.windowmaker.org/pub/libs/${P}.tar.gz"
HOMEPAGE="http://www.windowmaker.org/"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"

DEPEND="virtual/glibc"

src_compile() {

	./configure --prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/state/libPropList \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--build=${CHOST} \
		--host=${CHOST} \
		--target=${CHOST} || die "configure failed"

	make || die "make failed"

}

src_install() {

	make prefix=${D}/usr install || die

	dodoc AUTHORS COPYING* ChangeLog README TODO

}
