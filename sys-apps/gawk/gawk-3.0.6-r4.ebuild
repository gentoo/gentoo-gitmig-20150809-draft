# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gawk/gawk-3.0.6-r4.ebuild,v 1.3 2001/10/06 17:04:49 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU awk pattern-matching language"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gawk/${P}.tar.gz ftp://prep.ai.mit.edu/gnu/gawk/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gawk/gawk.html"
DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr --libexecdir=/usr/lib/awk --mandir=/usr/share/man --infodir=/usr/share/info --host=${CHOST} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man/man1 infodir=${D}/usr/share/info libexecdir=${D}/usr/lib/awk install || die
	if [ -z "`use build`" ] 
	then
		dosym gawk.1.gz /usr/share/man/man1/awk.1.gz
		dodoc ChangeLog ACKNOWLEDGMENT COPYING FUTURES
		dodoc LIMITATIONS NEWS PROBLEMS README
		docinto README_d
		dodoc README_d/*
		docinto atari
		dodoc atari/ChangeLog atari/README.1st
		docinto awklib
		dodoc awklib/ChangeLog
		docinto pc
		dodoc pc/ChangeLog
		docinto posix
		dodoc posix/ChangeLog
	else
		rm -rf ${D}/usr/share
	fi
}
