# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gawk/gawk-3.0.4-r1.ebuild,v 1.3 2000/09/15 20:09:19 drobbins Exp $

P=gawk-3.0.4     
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU awk pattern-matching language"
SRC_URI="ftp://prep.ai.mit.edu/gnu/gawk/gawk-3.0.4.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gawk/gawk.html"

src_compile() {                           
	try ./configure --prefix=/usr --host=${CHOST}
	try make
}

src_install() {                               
        into /usr
	doinfo doc/gawk.info
	doman doc/gawk.1 doc/igawk.1
	dobin gawk awklib/igawk 
	dosym gawk /usr/bin/awk
	dosym gawk /usr/bin/gawk-3.0.4
	insinto /usr/share/awk
	doins awklib/eg/lib/*.awk awklib/*.awk
	exeinto /usr/libexec/awk
	doexe awklib/*cat 
	dodoc ChangeLog ACKNOWLEDGMENT COPYING FUTURES LIMITATIONS NEWS PROBLEMS README
}


