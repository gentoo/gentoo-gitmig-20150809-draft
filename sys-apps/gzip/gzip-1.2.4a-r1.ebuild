# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gzip/gzip-1.2.4a-r1.ebuild,v 1.4 2000/10/03 16:02:04 achim Exp $

P=gzip-1.2.4a      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU compressor"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gzip/${A}
	 ftp://prep.ai.mit.edu/gnu/gzip/${A}"
HOMEPAGE="http://www.gnu.org/software/gzip/gzip.html"

src_compile() {                           
	try ./configure --host=${CHOST} --prefix=/usr
	try make
}

src_install() {               
	into /usr                
	doman *.1
	dosym gzip.1.gz /usr/man/man1/gunzip.1.gz
	dosym gzip.1.gz /usr/man/man1/zcat.1.gz	
	dosym zdiff.1.gz /usr/man/man1/zcmp.1.gz
	doinfo gzip.info
	dobin gzip
	insopts -m0755
	insinto /usr/bin
	for x in zdiff zgrep zmore znew zforce gzexe
	do
	    sed -e "1d" -e "s|BINDIR|/usr/bin|" ${x}.in > ${x}
	    doins ${x}
	done
	dosym gzip /usr/bin/zcat
	dosym gzip /usr/bin/gunzip
	dosym gzip /usr/bin/zcat
	dosym zdiff /usr/bin/zcmp
	dodoc ChangeLog COPYING NEWS README THANKS TODO algorithm.doc 
}


