# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gawk/gawk-3.0.6.ebuild,v 1.1 2000/08/25 15:10:24 achim Exp $

P=gawk-3.0.6
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU awk pattern-matching language"
SRC_URI="ftp://prep.ai.mit.edu/gnu/gawk/${A}"
HOMEPAGE="http://www.gnu.org/software/gawk/gawk.html"

src_compile() {                           
	./configure --prefix=/usr --host=${CHOST}
	make
}

src_install() {                               
        into /usr
	doinfo doc/gawk.info
	doman doc/gawk.1 doc/igawk.1
	dobin gawk awklib/igawk 
	dosym gawk /usr/bin/awk
	dosym gawk /usr/bin/gawk-3.0.6
	insinto /usr/share/awk
	doins awklib/eg/lib/*.awk awklib/*.awk
	exeinto /usr/libexec/awk
	doexe awklib/*cat 
	dodoc ChangeLog ACKNOWLEDGMENT COPYING FUTURES LIMITATIONS NEWS PROBLEMS README
}


