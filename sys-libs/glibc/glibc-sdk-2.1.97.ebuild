# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-sdk-2.1.97.ebuild,v 1.3 2000/11/10 11:55:21 achim Exp $

A="glibc-${PV}.tar.bz2 glibc-linuxthreads-${PV}.tar.gz"
S=${WORKDIR}/glibc-${PV}
DESCRIPTION="GNU libc6 (also called glibc2) C library"
SRC_URI="ftp://sourceware.cygnus.com/pub/glibc/releases/glibc-${PV}.tar.bz2
	 ftp://sourceware.cygnus.com/pub/glibc/releases/glibc-linuxthreads-${PV}.tar.gz
 	 ftp://ftp.unina.it/pub/Unix/cygnus/glibc/releases/glibc-${PV}.tar.bz2
	 ftp://ftp.unina.it/pub/Unix/cygnus/glibc/releases/glibc-linuxthreads-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"

export TCPU="i686"
export THOST="${TCPU}-glibc${PV}-linux"

src_compile() {                           
        rm -rf buildhere
	mkdir buildhere
	cd buildhere
	PATH=/usr/${THOST}/bin:$PATH
	../configure --without-cvs \
		--prefix=/usr/${THOST}/${THOST} \
		--datadir=/usr/${THOST}/lib \
		--enable-add-ons=linuxthreads,crypt,localedata \
		--disable-profile --host=${CHOST} --target=${THOST} 

	try make 
	#datadir=/usr/{THOST}/lib
	make check
}

src_unpack() {

    unpack glibc-${PV}.tar.bz2
    cd ${S}
    unpack glibc-linuxthreads-${PV}.tar.gz

}

src_install() {
    cd ${S}
    try make install_root=${D} install -C buildhere
    cd ${D}/usr/${THOST}/${THOST}/include
    ln -s /usr/src/linux/include/linux linux
    ln -s /usr/src/linux/include/asm asm
}



