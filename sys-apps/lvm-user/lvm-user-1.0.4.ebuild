# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lvm-user/lvm-user-1.0.4.ebuild,v 1.4 2002/08/14 03:37:20 murphy Exp $

NV=1.0.4
S=${WORKDIR}/LVM/${NV}
DESCRIPTION="User-land utilities for LVM (Logical Volume Manager) software"
SRC_URI="ftp://ftp.sistina.com/pub/LVM/1.0/lvm_${NV}.tar.gz"
HOMEPAGE="http://www.sistina.com/"
KEYWORDS="x86 -ppc sparc sparc64"

DEPEND="virtual/glibc
	virtual/linux-sources"
RDEPEND="virtual/glibc"
LICENSE="GPL-2 LGPL"
SLOT="0"

KS=/usr/src/linux

src_compile() {
	cd ${S}
	#This ebuild doesn't like this opt setting; closes bug #598
	export CFLAGS="${CFLAGS/-fomit-frame-pointer/}"
	[ -f "Makefile" ] && ( make clean || die )
	CFLAGS="${CFLAGS} -I${KS}/include" \
		./configure --prefix=/ \
		--mandir=/usr/share/man \
		--with-kernel_dir="${KS}" || die
	make || die
}

src_install() {
	cd ${S}/tools
	CFLAGS="${CFLAGS} -I${KS}/include" \
		make install \
		-e prefix=${D} \
		mandir=${D}/usr/share/man \
		sbindir=${D}/sbin \
		libdir=${D}/lib || die
	#no need for a static library in /lib
	dodir /usr/lib
	mv ${D}/lib/*.a ${D}/usr/lib
        cd ${S}
	dodoc ABSTRACT CHANGELOG CONTRIBUTORS COPYING COPYING.LIB KNOWN_BUGS FAQ INSTALL LVM-HOWTO README TODO WHATSNEW
}

