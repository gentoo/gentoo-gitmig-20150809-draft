# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-5.2.1.ebuild,v 1.2 2002/09/14 15:51:25 bjb Exp $

S=${WORKDIR}/${P}

DESCRIPTION="GNU debugger"
HOMEPAGE="http://sources.redhat.com/gdb/"
SRC_URI="http://mirrors.rcn.net/pub/sourceware/gdb/releases/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r2
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r2"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/man.diff || die "patch failed"

}

src_compile() {

	local myconf
	
	use nls && myconf="--enable-nls" || myconf="--disable-nls"

	econf ${myconf} || die

	make || die
}

src_install() {

	 make    \
                prefix=${D}/usr \
                mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
                install || die

	cd gdb/doc
	make 	\
		infodir=${D}/usr/share/info \
		install-info || die

	cd ${S}/bfd/doc
	make 	\
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
