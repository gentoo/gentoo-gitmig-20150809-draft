# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-5.2.1.ebuild,v 1.11 2004/01/19 18:27:58 azarah Exp $

inherit flag-o-matic

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="GNU debugger"
HOMEPAGE="http://sources.redhat.com/gdb/"
SRC_URI="http://mirrors.rcn.net/pub/sourceware/gdb/releases/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=">=sys-libs/ncurses-5.2-r2
	nls? ( sys-devel/gettext )"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/man.diff || die "patch failed"

}

src_compile() {

	local myconf

	use nls && myconf="--enable-nls" || myconf="--disable-nls"

	replace-flags -O? -O2
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
	rm -f ${D}/usr/lib/libiberty.*
	rm -f ${D}/usr/lib/libopcodes.*
	rm -f ${D}/usr/share/info/{bfd,configure,standards}.info*

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
