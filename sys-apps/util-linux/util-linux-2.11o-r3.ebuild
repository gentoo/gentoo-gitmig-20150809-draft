# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.11o-r3.ebuild,v 1.6 2002/09/21 03:50:17 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Various useful Linux utilities"
SRC_URI="http://www.kernel.org/pub/linux/utils/${PN}/${P}.tar.gz
         http://www.kernel.org/pub/linux/kernel/people/hvr/util-linux-patch-int/${P}.patch.gz"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r2
	sys-apps/pam-login"

RDEPEND="$DEPEND sys-devel/perl
	nls? ( sys-devel/gettext )"

SLOT="0"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${WORKDIR}
	cd ${S}
	gunzip -c ${DISTDIR}/${P}.patch.gz | patch -p0
	cp MCONFIG MCONFIG.orig
	sed -e "s:-pipe -O2 \$(CPUOPT) -fomit-frame-pointer:${CFLAGS}:"	\
		-e "s:CPU=.*:CPU=${CHOST%%-*}:"	\
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
	make DESTDIR=${D} install || die

	dodoc HISTORY MAINTAINER README VERSION
	docinto licenses
	dodoc licenses/* HISTORY
	docinto examples
	dodoc example.files/*
}

