# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lvm-user/lvm-user-1.0.5.ebuild,v 1.10 2003/06/21 21:19:40 drobbins Exp $

inherit flag-o-matic

S=${WORKDIR}/LVM/${PV}
DESCRIPTION="User-land utilities for LVM (Logical Volume Manager) software"
SRC_URI="ftp://ftp.sistina.com/pub/LVM/1.0/lvm_${PV}.tar.gz"
HOMEPAGE="http://www.sistina.com/"
KEYWORDS="x86 amd64 -ppc sparc "

DEPEND="virtual/glibc
	virtual/linux-sources"
RDEPEND="virtual/glibc"
LICENSE="GPL-2 | LGPL-2"
SLOT="0"

KS=/usr/src/linux

src_compile() {
	addwrite /dev/stderr
	filter-flags -fomit-frame-pointer
	if [ -f "Makefile" ];then
		make clean || die
	fi
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

