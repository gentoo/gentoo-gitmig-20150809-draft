# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-5.3.ebuild,v 1.9 2003/05/19 22:50:24 kumba Exp $

IUSE="nls objc"

S=${WORKDIR}/${P}
DESCRIPTION="GNU debugger"
HOMEPAGE="http://sources.redhat.com/gdb/"
SRC_URI="http://mirrors.rcn.net/pub/sourceware/gdb/releases/${P}.tar.bz2
	objc? ( ftp://ftp.gnustep.org/pub/gnustep/patches/gdb-5_3-objc-patch.tgz )"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha hppa"

DEPEND=">=sys-libs/ncurses-5.2-r2
	nls? ( sys-devel/gettext )"

inherit flag-o-matic
replace-flags -O? -O2

src_unpack() {
	unpack gdb-${PV}.tar.bz2

	if [ "${ARCH}" = "hppa" ]; then
		cd ${S}
		patch -p1 < ${FILESDIR}/gdb-5.3-hppa-01.patch
		patch -p1 < ${FILESDIR}/gdb-5.3-hppa-02.patch
		patch -p1 < ${FILESDIR}/gdb-5.3-hppa-03.patch
	fi


	# Fix Compile bug on sparc
	if [ "${ARCH}" = "sparc" ]; then
		cd ${S}
		epatch ${FILESDIR}/${P}-sparc-nat-asm.patch
	fi


	if [ -n "`use objc`" ] ; then
		unpack gdb-5_3-objc-patch.tgz 
		cd ${S}

		patch -p1 < ${WORKDIR}/gdb-5_3-objc-patch/gdb-5.3-objc-patch.diff || die

		cp ${WORKDIR}/gdb-5_3-objc-patch/objc-exp.y gdb/
		cp ${WORKDIR}/gdb-5_3-objc-patch/objc-lang.c gdb/
		cp ${WORKDIR}/gdb-5_3-objc-patch/objc-lang.h gdb/
		cp -r ${WORKDIR}/gdb-5_3-objc-patch/gdb.objc gdb/testsuite/
		cd gdb/testsuite
		autoconf || die
	fi
}

src_compile() {

	local myconf
	
	use nls && myconf="--enable-nls" || myconf="--disable-nls"

	econf ${myconf} || die

	make || die
}

src_install() {

	 make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	cd gdb/doc
	make \
		infodir=${D}/usr/share/info \
		install-info || die

	cd ${S}/bfd/doc
	make \
		infodir=${D}/usr/share/info \
		install-info || die

	cd ${S}

	# These includes and libs are in binutils already
	rm -f ${D}/usr/lib/libbfd.*
	rm -r ${D}/usr/lib/libiberty.*
	rm -f ${D}/usr/lib/libopcodes.*

	rm -rf ${D}/usr/include

	dodoc COPYING* README

	docinto gdb
	dodoc gdb/CONTRIBUTE gdb/COPYING* gdb/README \
		gdb/MAINTAINERS gdb/NEWS gdb/ChangeLog* \
		gdb/TODO

	docinto sim
	dodoc sim/ChangeLog sim/MAINTAINERS sim/README-HACKING

	docinto mmalloc
	dodoc mmalloc/COPYING.LIB mmalloc/MAINTAINERS \
		mmalloc/ChangeLog mmalloc/TODO
}
