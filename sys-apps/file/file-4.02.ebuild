# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-4.02.ebuild,v 1.15 2004/06/30 15:50:36 agriffis Exp $

inherit flag-o-matic

DESCRIPTION="Program to identify a file's format by scanning binary data for patterns"
HOMEPAGE="ftp://ftp.astron.com/pub/file/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE="build"

DEPEND="virtual/libc"

src_compile() {

	# file command segfaults on hppa -  reported by gustavo@zacarias.com.ar
	[ ${ARCH} = "hppa" ] && filter-flags "-mschedule=8000"

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--datadir=/usr/share/misc \
		--host=${CHOST} || die

	#unfortunately, parallel make doesn't work with 4.01
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die

	if ! use build ; then
		dodoc LEGAL.NOTICE MAINT README || die
	else
		rm -rf ${D}/usr/share/man
	fi
}
