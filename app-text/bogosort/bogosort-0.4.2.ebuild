# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bogosort/bogosort-0.4.2.ebuild,v 1.2 2004/12/15 22:50:04 hansmi Exp $

inherit libtool eutils

DESCRIPTION="A file sorting program which uses the bogosort algorithm"
HOMEPAGE="http://www.lysator.liu.se/~qha/bogosort/"
SRC_URI="ftp://ulrik.haugen.se/pub/unix/bogosort/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips ~ppc"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/xmalloc.patch
}

src_install() {
	make DESTDIR="${D}" install
	dodoc README NEWS ChangeLog AUTHORS
}
