# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/joe/joe-2.9.5.ebuild,v 1.14 2004/02/24 09:46:49 kumba Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="A free ASCII-Text Screen Editor for UNIX"
SRC_URI="mirror://sourceforge/joe-editor/${P}.tgz"
HOMEPAGE="http://sourceforge.net/projects/joe-editor/"

SLOT="0"
KEYWORDS="x86 ppc sparc "
LICENSE="GPL-1"

DEPEND=">=sys-libs/ncurses-5.2-r2"

PROVIDE="virtual/editor"

src_compile() {
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
	make joe termidx || die
}

src_install() {
	into /usr
	dobin joe
	doman joe.1
	dolib joerc
	for i in jmacs jstar jpico rjoe
	do
		dosym joe /usr/bin/$i
		dosym joe.1.gz /usr/share/man/man1/$i.1.gz
		dolib ${i}rc
	done

	dodoc copying INFO LIST README TODO VERSION
}
