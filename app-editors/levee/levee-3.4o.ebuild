# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/levee/levee-3.4o.ebuild,v 1.16 2005/01/01 13:30:47 eradicator Exp $

IUSE=""

S=${WORKDIR}/${PN}
DESCRIPTION="Really tiny vi clone, for things like rescue disks"
HOMEPAGE="http://www.pell.chi.il.us/~orc/Code/"
SRC_URI="http://www.pell.chi.il.us/~orc/Code/${PN}.tar.gz"

SLOT="0"
LICENSE="levee"
KEYWORDS="x86 ppc sparc"

DEPEND="sys-libs/ncurses"

src_compile() {
	sed -i -e "/^CFLAGS/ s:-O:${CFLAGS}:" Makefile
	make LIBES=-lncurses || die
}

src_install() {
	exeinto /usr/bin
	newexe lev lv
	doman lv.1
}
