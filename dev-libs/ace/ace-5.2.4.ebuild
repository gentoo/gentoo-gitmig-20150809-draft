# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ace/ace-5.2.4.ebuild,v 1.1 2002/08/31 18:42:23 prez Exp $

S=${WORKDIR}/ACE_wrappers
DESCRIPTION="The Adaptive Communications Environment"
SRC_URI="http://deuce.doc.wustl.edu/old_distribution/ACE-${PV}.tar.gz"
HOMEPAGE="http://www.cs.wustl.edu/~schmidt/ACE.html"

SLOT="0"
LICENSE="BSD as-is"
KEYWORDS="x86 sparc sparc64"

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
	cp libACE.so ${D}/usr/lib/libACE.so.${PV}
	cp libACE.a ${D}/usr/lib/libACE.a
	cd ${D}/usr/lib
	ln -s libACE.so.${PV} libACE.so.`echo ${PV} | cut -f1 -d.`
	ln -s libACE.so.${PV} libACE.so

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

pkg_postinst() {
	# This is required, as anything trying to compile against ACE will have
	# problems with conflicting OS.h files if this is not done.

	local CC_MACHINE=`gcc -dumpmachine`
	local CC_VERSION=`gcc -dumpversion`
	if [ -d "/usr/lib/gcc-lib/${CC_MACHINE}/${CC_VERSION}/include/ace" ]; then
		mv "/usr/lib/gcc-lib/${CC_MACHINE}/${CC_VERSION}/include/ace" \
		   "/usr/lib/gcc-lib/${CC_MACHINE}/${CC_VERSION}/include/ace.old"
	fi
}
