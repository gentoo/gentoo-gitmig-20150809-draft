# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/adns/adns-1.1.ebuild,v 1.2 2004/01/03 13:54:50 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Advanced, easy to use, asynchronous-capable DNS client library and utilities"
HOMEPAGE="http://www.chiark.greenend.org.uk/~ian/adns/"
SRC_URI="ftp://ftp.chiark.greenend.org.uk/users/ian/adns/${P}.tar.gz"


SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~ia64 amd64"

DEPEND="virtual/glibc"

src_compile() {

	econf || die
	emake || die

}

src_install () {
	dodir /usr/{include,bin,lib}
	make prefix=${D}/usr install || die
	dodoc README GPL-vs-LGPL COPYING TODO
	dohtml *.html

	cd ${D}/usr/lib
	dosym libadns.so.1 /usr/lib/libadns.so
}
