# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lvm-user/lvm-user-1.0.1_rc4.ebuild,v 1.1 2001/11/24 02:13:35 drobbins Exp $

#our version, but with "eh" formatting
NV=1.0.1-rc4
S=${WORKDIR}/LVM/${NV}
DESCRIPTION="User-land utilities for MOSIX process migration (clustering) software"
SRC_URI="ftp://ftp.sistina.com/pub/LVM/1.0/lvm_${NV}.tar.gz"
HOMEPAGE="http://www.mosix.org"
DEPEND="virtual/glibc"

KS=/usr/src/linux

src_compile() {
	cd ${S}
	[ -f "Makefile" ] && ( make clean || die )
	CFLAGS="${CFLAGS} -I${KS}/include" ./configure --prefix=/ --mandir=/usr/share/man --with-kernel_dir="${KS}" || die
	make || die
}

src_install () {
	cd ${S}/tools
	CFLAGS="${CFLAGS} -I${KS}/include" make install -e prefix=${D} mandir=${D}/usr/share/man sbindir=${D}/sbin libdir=${D}/lib || die
	#no need for a static library in /lib
	dodir /usr/lib
	mv ${D}/lib/*.a ${D}/usr/lib
}

