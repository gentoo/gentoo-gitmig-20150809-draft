# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/levee/levee-3.4o.ebuild,v 1.11 2002/12/09 04:17:40 manson Exp $

DESCRIPTION="Really tiny vi clone, for things like rescue disks"
HOMEPAGE="http://www.pell.chi.il.us/~orc/Code/"
SRC_URI="http://www.pell.chi.il.us/~orc/Code/${PN}.tar.gz"

SLOT="0"
LICENSE="levee"
KEYWORDS="x86 ppc sparc "

DEPEND="sys-libs/ncurses"
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "/^CFLAGS/ s/-O/${CFLAGS}/" < Makefile > Makefile.out
	mv Makefile.out Makefile
}

src_compile() {
	make LIBES=-lncurses || die
}

src_install() {
	exeinto /usr/bin
	newexe lev lv
	doman lv.1
}
