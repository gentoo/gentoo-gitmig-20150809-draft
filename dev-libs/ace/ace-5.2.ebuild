# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ace/ace-5.2.ebuild,v 1.4 2002/08/01 16:07:17 seemant Exp $

S=${WORKDIR}/ACE_wrappers
ACE_VER=5.2
DESCRIPTION="The Adaptive Communications Environment"
SRC_URI="http://deuce.doc.wustl.edu/ACE-${ACE_VER}.tar.gz
	ftp://deuce.doc.wustl.edu/pub/ACE+TAO-distribution/ACE-${ACE_VER}.tar.gz"
HOMEPAGE="http://www.cs.wustl.edu/~schmidt/ACE.html"

SLOT="0"
LICENSE="BSD as-is"
KEYWORDS="x86"

DEPEND="virtual/glibc"


src_unpack() {

	unpack ${A}
	cd ${S}/ace
	cp config-linux.h config.h
	cd ${S}/include/makeinclude
	sed -e "s:-O3:${CFLAGS}:" platform_linux.GNU >platform_macros.GNU
}

src_compile() {

	export ACE_ROOT=${S}
	cd ${S}
	emake static_libs=1 || die
}

src_install() {

	dodir /usr/include/ace /usr/lib /usr/share/man/man3

	cd ${S}/ace
	cp libACE.so ${D}/usr/lib/libACE.so.${ACE_VER}
	cp libACE.a ${D}/usr/lib/libACE.a
	cd ${D}/usr/lib
	ln -s libACE.so.${ACE_VER} libACE.so.`echo ${ACE_VER} | cut -f1 -d.`
	ln -s libACE.so.${ACE_VER} libACE.so

	cd ${S}/ace
	cp -r *.h *.cpp *.i *.inl ${D}/usr/include/ace
	chmod 644 ${D}/usr/include/ace/*

	cd ${S}/man/man3
	cp *.3 ${D}/usr/share/man/man3
	chmod 644 ${D}/usr/share/man/man3/*.3
	gzip ${D}/usr/share/man/man3/*.3

	cd ${S}
	dodoc ACE-INSTALL* AUTHORS COPYING FAQ PROBLEM-REPORT-FORM README
	dodoc THANKS TODO VERSION
	cd ${S}/docs
	dodoc *.html *.txt *gz
	cd ${S}
	docinto ChangeLogs
	dodoc ChangeLog
	cd ${S}/ChangeLogs
	dodoc ChangeLog*
}
