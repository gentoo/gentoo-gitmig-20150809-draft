# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-glibc-2_1_97-sdk-2.10.0.33.ebuild,v 1.1 2000/11/07 13:23:52 achim Exp $

GLIBCV="2.1.97"

A=binutils-2.10.0.33.tar.gz

S=${WORKDIR}/binutils-2.10.0.33
DESCRIPTION="Tools necessary to build programs"
SRC_URI="ftp://ftp.varesearch.com/pub/support/hjl/binutils/${A}"

src_compile() {    
	try ./configure --prefix=/opt/glibc-${GLIBCV}-sdk --host=${CHOST}  \
	    --target=${CHOST} 
	cd ld
	cp Makefile Makefile.orig
	sed -e "s:^tdir_elf_i386=${CHOST}:tdir_elf_i386=i686-linux-glibc-${GLIBCV}:" \
	Makefile.orig > Makefile	
	cd ..
	try make target_alias=i686-linux-glibc-${GLIBCV}
}

src_install() {
	#I'm sure this can be simplified with a "try make PREFIX=${D}/usr install"
	#one of these days...     
	try make target_alias=i686-linux-glibc-${GLIBCV} prefix=${D}/opt/glibc-${GLIBCV}-sdk install

        cd ${D}/opt/glibc-${GLIBCV}-sdk/${CHOST}/lib/ldscripts

	for i in *
	do
	  cp $i $i.orig
	  sed -e "s:^SEARCH_DIR.*:SEARCH_DIR(/opt/glibc-${GLIBCV}-sdk/lib); SEARCH_DIR(/opt/glibc-${GLIBCV}-sdk/i686-linux-glibc-${GLIBCV}/lib); SERACH_DIR(/lib); SEARCH_DIR(/usr/lib); SEARCH_DIR(/usr/local/lib);:" $i.orig > $i
	  rm $i.orig
	done
	cd ${S}           
	rm -r bin include lib man share
	mv ${CHOST}/* .
	rm -r ${CHOST}
	dodoc COPYING* README* ChangeLog* mpw-README
	docinto bfd
        dodoc bfd/ChangeLog* bfd/COPYING bfd/README bfd/PORTING bfd/TODO
	docinto binutils
 	dodoc binutils/MAINTAINERS binutils/NEWS binutils/README
	docinto gas
	dodoc gas/ChangeLog* gas/CONTRIBUTORS gas/COPYING gas/MAINTAINERS gas/NEWS gas/README*
	docinto gprof
	dodoc gprof/ChangeLog* gprof/MAINTAINERS gprof/NOTES gprof/TEST gprof/TODO
	docinto include
	dodoc include/ChangeLog* include/COPYING include/MAINTAINERS
	docinto intl
	dodoc intl/ChangeLog
	docinto ld
	dodoc ld/ChangeLog* ld/MAINTAINERS ld/README ld/NEWS ld/TODO
	docinto libiberty
	dodoc libiberty/ChangeLog* libiberty/COPYING.LIB libiberty/README 
	docinto opcodes
	dodoc opcodes/ChangeLog* opcodes/MAINTAINERS
	
}



