# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/gzip/gzip-1.2.4a-r1.ebuild,v 1.2 2001/02/15 18:17:31 achim Exp $

P=gzip-1.2.4a      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU compressor"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gzip/${A}
	 ftp://prep.ai.mit.edu/gnu/gzip/${A}"
HOMEPAGE="http://www.gnu.org/software/gzip/gzip.html"

src_compile() {                           
	try ./configure --host=${CHOST} --prefix=/usr --disable-nls
	try pmake LDFLAGS=-static ${MAKEOPTS}
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
        rm -rf ${D}/usr
}




