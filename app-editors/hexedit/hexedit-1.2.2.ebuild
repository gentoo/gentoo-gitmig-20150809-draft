# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/hexedit/hexedit-1.2.2.ebuild,v 1.6 2002/08/14 18:36:02 murphy Exp $

S="${WORKDIR}/hexedit"
DESCRIPTION="View and edit files in hex or ASCII."
SRC_URI="http://merd.net/pixel/${P}.src.tgz"
HOMEPAGE="http://www.chez.com/prigaux/hexedit.html"

DEPEND="virtual/glibc
	sys-libs/ncurses"
RDEPEND=""

SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="GPL-1"

src_compile() {
	cd "${S}"
	./configure --host="${CHOST}" --prefix=/usr --mandir=/usr/share/man \
	|| die "./configure failed"
	
	emake || die
}

src_install () {
	dobin hexedit
	doman hexedit.1
	dodoc COPYING Changes TODO
}
