# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.2-r2.ebuild,v 1.1 2000/11/15 18:09:12 achim Exp $

A="$P.tar.gz glibc-linuxthreads-${PV}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="GNU libc6 (also called glibc2) C library"
SRC_URI="ftp://sourceware.cygnus.com/pub/glibc/releases/glibc-${PV}.tar.gz
	 ftp://sourceware.cygnus.com/pub/glibc/releases/glibc-linuxthreads-${PV}.tar.gz
	 ftp://ftp.unina.it/pub/Unix/cygnus/glibc/releases/glibc-${PV}.tar.gz
	 ftp://ftp.unina.it/pub/Unix/cygnus/glibc/releases/glibc-linuxthreads-${PV}.tar.gz
	 ftp://ftp.gnu.org/pub/gnu/glibc/glibc-${PV}.tar.gz
	 ftp://ftp.gnu.org/pub/gnu/glibc/glibc-linuxthreads-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"

src_compile() {                           

        rm -rf buildhere
	mkdir buildhere
	cd buildhere
	try ../configure --host=${CHOST} --without-cvs \
		--enable-add-ons=linuxthreads,crypt,localedata \
		--disable-profile --prefix=/usr \
		--enable-kernel=2.2.17
	try make
	make check
}

src_unpack() {
    unpack glibc-${PV}.tar.gz
    cd ${S}
    unpack glibc-linuxthreads-${PV}.tar.gz
    patch -p0 < ${FILESDIR}/glibc-2.2-ldconfig.patch
}

src_install() {
    cd ${S}
    rm -rf ${D}
    mkdir ${D}	
    dodir /etc/rc.d/init.d
    export LC_ALL=C
    try make install_root=${D} install -C buildhere
    try make install_root=${D} info -C buildhere
    try make install_root=${D} localedata/install-locales -C buildhere
    try make -C linuxthreads/man
    mkdir -p ${D}/usr/man/man3
    install -m 0644 linuxthreads/man/*.3thr ${D}/usr/man/man3
    chmod 755 ${D}/usr/libexec/pt_chown
    install -m 644 nscd/nscd.conf ${D}/etc
    install -m 755 ${O}/files/nscd ${D}/etc/rc.d/init.d/nscd
    dodir /var/db
    install -m 644 nss/db-Makefile ${D}/var/db/Makefile
    rm ${D}/lib/ld-linux.so.2
    rm ${D}/lib/libc.so.6
    rm -rf documentation
    mkdir documentation
    mkdir documentation/html
    cp linuxthreads/ChangeLog  documentation/ChangeLog.threads
    cp linuxthreads/Changes documentation/Changes.threads
    cp linuxthreads/README documentation/README.threads
    cp linuxthreads/FAQ.html documentation/html/FAQ-threads.html
    cp crypt/README documentation/README.crypt
    cp db2/README documentation/README.db2
    cp db2/mutex/README documentation/README.db2.mutex
    cp timezone/README documentation/README.timezone
    cp ChangeLog* documentation
    dodoc documentation/*
    docinto html
    dodoc documentation/html/*.html
    dodir /usr/doc/${PF}/examples.threads
    install -m0644 linuxthreads/Examples/*.c ${D}/usr/doc/${PF}/examples.threads
    install -m0644 linuxthreads/Examples/Makefile ${D}/usr/doc/${PF}/examples.threads
    # Patch ucontext.h (needed for lynx, xfree)
    #cd ${D}/usr/include/sys
    #cp ucontext.h ucontext.h.orig
    #sed -e "s/ERR/GLIBCBUG/g" ucontext.h.orig > ucontext.h
}

pkg_preinst()
{
  echo "Saving ld-linux and libc6"

  cp ${ROOT}lib/ld-linux.so.2 ${ROOT}tmp
  sln ${ROOT}tmp/ld-linux.so.2 ${ROOT}lib/ld-linux.so.2
  cp ${ROOT}lib/libc.so.6 ${ROOT}tmp
  sln ${ROOT}tmp/libc.so.6 ${ROOT}lib/libc.so.6
}

pkg_postinst()
{
  echo "Setting ld-linux and libc6"

  sln ${ROOT}lib/ld-2.2.so ${ROOT}lib/ld-linux.so.2
  sln ${ROOT}lib/libc-2.2.so ${ROOT}lib/libc.so.6
  rm  ${ROOT}tmp/ld-linux.so.2
  rm  ${ROOT}tmp/libc.so.6
}


