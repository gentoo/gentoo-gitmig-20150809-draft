# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/figlet/figlet-22-r1.ebuild,v 1.4 2003/02/20 13:53:28 gmsoft Exp $

S=${WORKDIR}/${PN}${PV}
DESCRIPTION="FIGlet is a program for making large letters out of ordinary text"
SRC_URI="ftp://ftp.plig.org/pub/figlet/program/unix/${PN}${PV}.tar.gz"
HOMEPAGE="http://st-www.cs.uiuc.edu/users/chai/figlet.html"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 sparc hppa"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die
	sed "s/CFLAGS = -g/CFLAGS = ${CFLAGS}/g" < Makefile > Makefile.new
	mv -f Makefile.new Makefile
}


src_compile() {
	make clean || die
	make figlet || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man6 
	chmod +x figlist showfigfonts
	make \
		DESTDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/man6 \
	    DEFAULTFONTDIR=${D}/usr/share/figlet \
		install || die

	dodoc Artistic-license.txt FTP-NOTE README showfigfonts figmagic figfont.txt
}
