# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_limitipconn/mod_limitipconn-0.22.ebuild,v 1.6 2004/09/03 23:24:08 pvdabeel Exp $

DESCRIPTION="Allows administrators to limit the number of simultaneous downloads permitted"
SRC_URI="http://dominia.org/djao/limit/${P}.tar.gz"
HOMEPAGE="http://dominia.org/djao/limitipconn.html"

KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="as-is"
IUSE=""

DEPEND="virtual/libc
	=net-www/apache-2*"
RDEPEND=""

src_compile() {
	apxs2 -c  mod_limitipconn.c || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/${PN}.so
	dodoc ChangeLog INSTALL README
}

