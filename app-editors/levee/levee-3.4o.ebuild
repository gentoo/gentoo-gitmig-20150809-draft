# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/levee/levee-3.4o.ebuild,v 1.4 2002/07/25 19:39:51 kabau Exp $

DESCRIPTION="Really tiny vi clone, for things like rescue disks"
HOMEPAGE="http://www.pell.chi.il.us/~orc/Code/"

SRC_URI="http://www.pell.chi.il.us/~orc/Code/${PN}.tar.gz"
S=${WORKDIR}/${PN}

DEPEND="sys-libs/ncurses"
RDEPEND=""

SLOT="0"
LICENSE=""
KEYWORDS="x86"

src_unpack () {
	unpack "${A}" || die
	cd ${S}
	sed -e "/^CFLAGS/ s/-O/${CFLAGS}/" < Makefile > Makefile.out
	mv Makefile.out Makefile
}

src_compile() {
	make LIBES=-lncurses || die
}

src_install () {
        exeinto /usr/bin
        newexe lev lv
	doman lv.1
}
