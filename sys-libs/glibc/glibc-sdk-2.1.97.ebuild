# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-sdk-2.1.97.ebuild,v 1.2 2000/11/07 14:38:05 achim Exp $

A="glibc-${PV}.tar.bz2 glibc-linuxthreads-${PV}.tar.gz"
S=${WORKDIR}/glibc-${PV}
DESCRIPTION="GNU libc6 (also called glibc2) C library"
SRC_URI="ftp://sourceware.cygnus.com/pub/glibc/releases/glibc-${PV}.tar.bz2
	 ftp://sourceware.cygnus.com/pub/glibc/releases/glibc-linuxthreads-${PV}.tar.gz
 	 ftp://ftp.unina.it/pub/Unix/cygnus/glibc/releases/glibc-${PV}.tar.bz2
	 ftp://ftp.unina.it/pub/Unix/cygnus/glibc/releases/glibc-linuxthreads-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"

src_compile() {                           

        rm -rf buildhere
	mkdir buildhere
	cd buildhere
	export PATH=/opt/${P}/bin:${PATH}
	try ../configure --host=${CHOST} --without-cvs \
		--prefix=/opt/${P} \
		--enable-add-ons=linuxthreads,crypt \
		--disable-profile \
		--with-binutils=/opt/${P}//bin

	try make datadir=/opt/{P}/lib
	make check
}

src_unpack() {
    unpack glibc-${PV}.tar.bz2
    cd ${S}
    unpack glibc-linuxthreads-${PV}.tar.gz

    # This patch is required to compile with binutils higher than
    # 2.9.5.0.42
    #cp ${O}/files/setjmp.S ${S}/sysdeps/i386/elf/setjmp.S
}

src_install() {
    cd ${S}
    try make install_root=${D} datadir=/opt/${P}/lib install -C buildhere
    cd ${D}/opt/${P}/include
    ln -s /usr/src/linux/include/linux linux
    ln -s /usr/src/linux/include/asm asm
}



