# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.1.95.ebuild,v 1.1 2000/10/29 20:53:46 achim Exp $

A="$P.tar.bz2 glibc-linuxthreads-${PV}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="GNU libc6 (also called glibc2) C library"
SRC_URI="ftp://sourceware.cygnus.com/pub/glibc/releases/glibc-${PV}.tar.bz2
	 ftp://sourceware.cygnus.com/pub/glibc/releases/glibc-linuxthreads-${PV}.tar.gz
 	 ftp://ftp.unina.it/pub/Unix/cygnus/glibc/releases/glibc-${PV}.tar.bz2
	 ftp://ftp.unina.it/pub/Unix/cygnus/glibc/releases/glibc-linuxthreads-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"

src_compile() {                           
	if [ "$CHOST" = "i686-pc-linux-gnu" ]
	then
		CHOST=i586-pc-linux-gnu #this is so there's no PII specific stuff
	fi
        rm -rf buildhere
	mkdir buildhere
	cd buildhere
	try ../configure --host=${CHOST} --without-cvs \
		--enable-add-ons=linuxthreads,crypt \
		 --disable-profile --prefix=/usr
	try make 
	try make check
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
    rm -rf ${D}
    mkdir ${D}	
    dodir /etc/rc.d/init.d
    try make install_root=${D} install -C buildhere
    try make -C linuxthreads/man
    mkdir -p ${D}/usr/man/man3
    install -m 0644 linuxthreads/man/*.3thr ${D}/usr/man/man3
    chmod 755 ${D}/usr/libexec/pt_chown
    install -m 644 nscd/nscd.conf ${D}/etc
    install -m 755 ${O}/files/nscd ${D}/etc/rc.d/init.d/nscd
    dodir /var/db
    install -m 644 nss/db-Makefile ${D}/var/db/Makefile
    strip ${D}/sbin/*
    strip ${D}/usr/bin/*
    strip ${D}/usr/sbin/*
    prepinfo
    prepman
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



