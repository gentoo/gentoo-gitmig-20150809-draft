# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hunt/hunt-1.5.ebuild,v 1.1 2004/02/03 02:13:49 vapier Exp $

DESCRIPTION="tool for checking well known weaknesses in the TCP/IP protocol"
HOMEPAGE="http://www.gncz.cz/kra/index.html"
SRC_URI="http://lin.fsid.cvut.cz/~kra/hunt/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2 -g:${CFLAGS}:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin hunt
	doman man/hunt.1
	dodoc CHANGES README* TODO tpsetup/transproxy
}
