# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/dia2code/dia2code-0.8.1.ebuild,v 1.4 2002/08/06 17:41:34 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Convert UML diagrams produced with Dia to various source code flavours."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://dia2code.sourceforge.net"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	dev-libs/libxml2"

RDEPEND="${DEPEND}
	>=app-office/dia-0.90.0"


src_compile () {
	# libxml2 header fix
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml"
	./configure --prefix=/usr \
                --host="${CHOST}"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
	doman dia2code.1
}

