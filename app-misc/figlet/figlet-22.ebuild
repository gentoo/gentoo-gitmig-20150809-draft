# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/figlet/figlet-22.ebuild,v 1.1 2001/04/27 18:33:33 aj Exp $

A=${PN}${PV}.tar.gz
S=${WORKDIR}/${PN}${PV}
DESCRIPTION="FIGlet is a program for making large letters out of ordinary text"
SRC_URI="ftp://ftp.plig.org/pub/figlet/program/unix/${A}"
HOMEPAGE="http://st-www.cs.uiuc.edu/users/chai/figlet.html"
DEPEND="virtual/glibc"

src_unpack() {
   unpack ${A}
   cd ${S}
   try patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
}


src_compile() {
   try make clean
   try make figlet 
}

src_install() {
   dodir /usr/bin /usr/share/man/man6 
   try DESTDIR=${D}/usr/bin MANDIR=${D}/usr/share/man/man6 \
       DEFAULTFONTDIR=${D}/usr/share/figlet make install

   dodoc Artistic-license.txt FTP-NOTE README showfigfonts figmagic figfont.txt
}

