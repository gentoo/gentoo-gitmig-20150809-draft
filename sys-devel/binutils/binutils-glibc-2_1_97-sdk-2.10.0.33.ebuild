# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-glibc-2_1_97-sdk-2.10.0.33.ebuild,v 1.2 2000/11/10 16:00:11 achim Exp $

export GLIBCV="2.1.97"

export TCPU="i686"
export THOST="${TCPU}-glibc${GLIBCV}-linux"
 
A=binutils-2.10.0.33.tar.gz

S=${WORKDIR}/binutils-2.10.0.33
DESCRIPTION="Tools necessary to build programs"
SRC_URI="ftp://ftp.varesearch.com/pub/support/hjl/binutils/${A}"

src_compile() {   
	cd ${S} 
	try ./configure --host=${CHOST}  --target=${THOST} \
	    --prefix=/usr/${TALIAS} 
#	cd ld
#	cp Makefile Makefile.orig
#	sed -e "s:^tdir_elf_i386=${CHOST}:tdir_elf_i386=${THOST}:" \
#	Makefile.orig > Makefile	
#	cd ..
	try make 
}

src_install() {
	#I'm sure this can be simplified with a "try make PREFIX=${D}/usr install"
	#one of these days...     
	try make prefix=${D}/usr/${THOST} install

#        cd ${D}/usr/${THOST}/${THOST}/lib/ldscripts
#	for i in *
#	do
#	  cp $i $i.orig
#	  sed -e "s:^ *SEARCH_DIR.*:SEARCH_DIR(/usr/${THOST}/lib); SEARCH_DIR(/usr/${THOST}/${THOST}/lib); SERACH_DIR(/lib); SEARCH_DIR(/usr/lib); SEARCH_DIR(/usr/local/lib);:g" $i.orig > $i
#	  rm $i.orig
#	done
	
}



