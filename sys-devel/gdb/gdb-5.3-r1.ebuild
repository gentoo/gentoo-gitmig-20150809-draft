# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-5.3-r1.ebuild,v 1.7 2004/08/03 04:31:00 vapier Exp $

inherit flag-o-matic ccc eutils

DESCRIPTION="GNU debugger"
HOMEPAGE="http://sources.redhat.com/gdb/"
SRC_URI="http://mirrors.rcn.net/pub/sourceware/gdb/releases/${P}.tar.bz2
	hppa? ( mirror://gentoo/${P}-hppa-patches.tar.bz2 )
	objc? ( ftp://ftp.gnustep.org/pub/gnustep/patches/gdb-5_3-objc-patch.tgz )
	mirror://gentoo/${P}-s390-june2003.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha arm -hppa ~amd64 ~ia64 s390"
IUSE="nls objc"

DEPEND=">=sys-libs/ncurses-5.2-r2
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack gdb-${PV}.tar.bz2
	unpack ${P}-s390-june2003.tar.gz

	if [ "${ARCH}" = "hppa" ]; then
		unpack ${P}-hppa-patches.tar.bz2
		cd ${S}
		EPATCH_SUFFIX="patch" epatch ${WORKDIR}/hppa
	fi

	#s390 Specific fixes to close Bug #47903
	if [ "${ARCH}" = "s390" ]; then
		patch -sp0 < ${WORKDIR}/gdb-5.3-s390-june2003.diff
	fi

	# Fix Compile bug on sparc
	if [ "${ARCH}" = "sparc" ]; then
		cd ${S}
		epatch ${FILESDIR}/${P}-sparc-nat-asm.patch
	fi


	if use objc ; then
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

	is-ccc && hide-restrict-arr
}

src_compile() {
	replace-flags -O? -O2
	econf `use_enable nls` || die
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
	rm -f ${D}/usr/lib/libiberty.*
	rm -f ${D}/usr/lib/libopcodes.*
	rm -f ${D}/usr/share/info/{bfd,configure,standards}.info*

	rm -rf ${D}/usr/include

	dodoc README

	docinto gdb
	dodoc gdb/CONTRIBUTE gdb/README gdb/TODO \
		gdb/MAINTAINERS gdb/NEWS gdb/ChangeLog*

	docinto sim
	dodoc sim/ChangeLog sim/MAINTAINERS sim/README-HACKING

	docinto mmalloc
	dodoc mmalloc/MAINTAINERS mmalloc/ChangeLog mmalloc/TODO
}
