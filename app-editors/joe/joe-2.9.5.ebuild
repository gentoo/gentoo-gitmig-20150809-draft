# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/joe/joe-2.9.5.ebuild,v 1.10 2003/01/06 10:41:54 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A free ASCII-Text Screen Editor for UNIX"
SRC_URI="mirror://sourceforge/joe-editor/${P}.tgz"
HOMEPAGE="http://sourceforge.net/projects/joe-editor/"

DEPEND=">=sys-libs/ncurses-5.2-r2"

PROVIDE="virtual/editor"

SLOT="0"
KEYWORDS="x86 ppc sparc "
LICENSE="GPL-1"

src_unpack() {

	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile

}

src_compile() {                           

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





