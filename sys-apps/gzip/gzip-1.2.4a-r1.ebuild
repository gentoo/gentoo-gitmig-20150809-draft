# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gzip/gzip-1.2.4a-r1.ebuild,v 1.7 2000/12/24 09:55:16 achim Exp $

P=gzip-1.2.4a      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU compressor"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gzip/${A}
	 ftp://prep.ai.mit.edu/gnu/gzip/${A}"
HOMEPAGE="http://www.gnu.org/software/gzip/gzip.html"
DEPEND=">=sys-libs/glibc-2.1.3"
RDEPEND="$DEPEND
	 >=sys-apps/bash-2.04"

src_compile() {                           
	try ./configure --host=${CHOST} --prefix=/usr --exec-prefix=/
	try pmake
}

src_install() { 
	dodir /usr/bin    
	try make prefix=${D}/usr exec_prefix=${D}/ install 
	cd ${D}/bin
	for i in gzexe zforce zgrep zmore znew zcmp
	do
	  cp ${i} ${i}.orig
	  sed -e "1d" -e "s:${D}::" ${i}.orig > ${i}
	  rm ${i}.orig
	  chmod 755 ${i}
	done
	cd ${D}/usr/man/man1
	
	for i in gzexe gzip zcat zcmp zdiff zforce \
		 zgrep zmore znew
	do
	  rm ${i}.1
	  ln -s gunzip.1.gz ${i}.1.gz
	done
	cd ${S}
	rm -rf ${D}/usr/lib
	dodoc ChangeLog COPYING NEWS README THANKS TODO 
	docinto txt
	dodoc algorithm.doc gzip.doc
}




