# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-4.03.ebuild,v 1.1 2003/09/03 18:04:13 mholzer Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Program to identify a file's format by scanning binary data for patterns"
SRC_URI="ftp://ftp.gw.com/mirrors/pub/unix/file/${P}.tar.gz
	ftp://ftp.astron.com/pub/file/${P}.tar.gz"
HOMEPAGE="ftp://ftp.astron.com/pub/file/"

KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~arm ~alpha ~hppa"
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/glibc"

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

	if [ -z "`use build`" ] ; then
		dodoc LEGAL.NOTICE MAINT README || die
	else
		rm -rf ${D}/usr/share/man
	fi
}
