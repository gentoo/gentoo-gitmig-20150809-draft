# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/hexedit/hexedit-1.2.2.ebuild,v 1.12 2004/01/18 20:22:37 zul Exp $

S="${WORKDIR}/hexedit"
DESCRIPTION="View and edit files in hex or ASCII."
SRC_URI="http://merd.net/pixel/${P}.src.tgz"
HOMEPAGE="http://www.chez.com/prigaux/hexedit.html"

DEPEND="virtual/glibc
	sys-libs/ncurses"
RDEPEND=""

SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"
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
