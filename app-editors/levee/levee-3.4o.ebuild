# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/levee/levee-3.4o.ebuild,v 1.3 2002/07/11 06:30:12 drobbins Exp $

DESCRIPTION="Really tiny vi clone, for things like rescue disks"
HOMEPAGE="http://www.pell.chi.il.us/~orc/Code/"

SRC_URI="http://www.pell.chi.il.us/~orc/Code/${PN}.tar.gz"
S=${WORKDIR}/${PN}

DEPEND="sys-libs/ncurses"

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
