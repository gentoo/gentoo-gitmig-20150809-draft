# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/glibc/glibc-2.2.1.ebuild,v 1.3 2001/01/27 22:04:24 achim Exp $

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
DEPEND=""
RDEPEND="$DEPEND
	 >=sys-apps/bash-2.04
	 >=sys-devel/perl-5.6"
PROVIDE="virtual/glibc"

src_compile() {                           

        rm -rf buildhere
	mkdir buildhere
	cd buildhere
	try ../configure --host=${CHOST} --without-cvs \
		--enable-add-ons=linuxthreads \
		--disable-profile --prefix=/usr \
		--enable-kernel=2.4.0 \
                --with-headers=${ROOT}/usr/include
	cp config.make config.orig
	sed -e "s:^LIBGD =.*:LIBGD = no:" config.orig > config.make
	try make PARALLELMFLAGS=${MAKEOPTS}
	
}

src_unpack() {
    unpack glibc-${PV}.tar.gz
    cd ${S}
    unpack glibc-linuxthreads-${PV}.tar.gz
#    patch -p1 < ${FILESDIR}/glibc-2.2-ldconfig.patch
}

src_install() {
    cd ${S}
    try make install_root=${D} install -C buildhere
#    try make install_root=${D} localedata/install-locales -C buildhere
    chmod 755 ${D}/usr/libexec/pt_chown
    rm -rf ${D}/usr/info
}



