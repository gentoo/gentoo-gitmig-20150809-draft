# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/adns/adns-1.1.ebuild,v 1.6 2004/04/28 04:36:35 vapier Exp $

inherit eutils

DESCRIPTION="Advanced, easy to use, asynchronous-capable DNS client library and utilities"
HOMEPAGE="http://www.chiark.greenend.org.uk/~ian/adns/"
SRC_URI="ftp://ftp.chiark.greenend.org.uk/users/ian/adns/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha hppa ~mips ia64 amd64"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc34.patch
}

src_install () {
	dodir /usr/{include,bin,lib}
	make prefix=${D}/usr install || die
	dodoc README TODO
	dohtml *.html

	cd ${D}/usr/lib
	dosym libadns.so.1 /usr/lib/libadns.so
}
