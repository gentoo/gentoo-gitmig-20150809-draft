# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.11o-r2.ebuild,v 1.1 2002/04/26 05:42:18 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Various useful Linux utilities"
SRC_URI="http://www.kernel.org/pub/linux/utils/${PN}/${P}.tar.gz
         http://www.kernel.org/pub/linux/kernel/people/hvr/util-linux-patch-int/${P}.patch.gz"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2-r2"

RDEPEND="$DEPEND sys-devel/perl
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${WORKDIR}
	cd ${S}
	gunzip -c ${DISTDIR}/${P}.patch.gz | patch -p0
	cp MCONFIG MCONFIG.orig
	#Build login etc; we will install only login manually....
	#We do this to fix a bug with shadow's login
	sed -e "s:-pipe -O2 \$(CPUOPT) -fomit-frame-pointer:${CFLAGS}:"	\
		-e "s:CPU=.*:CPU=${CHOST%%-*}:"	\
		-e "s:HAVE_SHADOW=yes:HAVE_SHADOW=no:" \
		-e "s:HAVE_PAM=no:HAVE_PAM=yes:"	\
		-e "s:HAVE_SLN=no:HAVE_SLN=yes:"	\
		-e "s:HAVE_TSORT=no:HAVE_TSORT=yes:"	\
		-e "s:usr/man:usr/share/man:"	\
		-e "s:usr/info:usr/share/info:"	\
			MCONFIG.orig > MCONFIG
}

src_compile() {

	./configure || die

	if [ -z "`use nls`" ]
	then
		cp defines.h defines.h.orig	
		cp Makefile Makefile.orig
		
		sed -e "s/#define ENABLE_NLS//g" 	\
			-e "s/#define HAVE_libintl_h//g"	\
			defines.h.orig > defines.h
	
		sed "s/\(^SUBDIRS=\)po/\1lib/g"	\
			Makefile.orig > Makefile
	fi
	
	emake LDFLAGS="" || die
	cd sys-utils; makeinfo *.texi || die
}

src_install() {
	#do not install all the login-utils; we will install login
	#manually ...
	cp MCONFIG MCONFIG.orig
	sed -e "s:HAVE_SHADOW=no:HAVE_SHADOW=yes:" \
	 	MCONFIG.orig > MCONFIG
		
	make DESTDIR=${D} install || die

	into /
	dobin login-utils/login
	doman login-utils/login.1
	
	dodoc HISTORY MAINTAINER README VERSION
	docinto licenses
	dodoc licenses/* HISTORY
	docinto examples
	dodoc example.files/*
}
