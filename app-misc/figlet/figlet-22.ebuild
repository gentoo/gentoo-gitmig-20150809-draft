# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/figlet/figlet-22.ebuild,v 1.2 2002/04/28 02:37:31 seemant Exp $

S=${WORKDIR}/${PN}${PV}
DESCRIPTION="FIGlet is a program for making large letters out of ordinary text"
SRC_URI="ftp://ftp.plig.org/pub/figlet/program/unix/${PN}${PV}.tar.gz"
HOMEPAGE="http://st-www.cs.uiuc.edu/users/chai/figlet.html"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die
}


src_compile() {
	make clean || die
	make figlet || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man6 
	make \
		DESTDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/man6 \
	    DEFAULTFONTDIR=${D}/usr/share/figlet \
		install || die

	dodoc Artistic-license.txt FTP-NOTE README showfigfonts figmagic figfont.txt
}
