# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.11o-r3.ebuild,v 1.16 2003/05/25 15:26:46 mholzer Exp $

inherit eutils

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Various useful Linux utilities"
SRC_URI="mirror://kernel/linux/utils/${PN}/${P}.tar.gz
	mirror://kernel/linux/kernel/people/hvr/util-linux-patch-int/${P}.patch.gz"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"
KEYWORDS="x86 ppc sparc mips"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r2
	sys-apps/pam-login"
RDEPEND="${DEPEND} dev-lang/perl
	nls? ( sys-devel/gettext )"

SLOT="0"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${WORKDIR}
	cd ${S}
	epatch ${DISTDIR}/${P}.patch.gz
	cp MCONFIG MCONFIG.orig
	sed -e "s:-pipe -O2 \$(CPUOPT) -fomit-frame-pointer:${CFLAGS}:" \
		-e "s:CPU=.*:CPU=${CHOST%%-*}:" \
		-e "s:HAVE_PAM=no:HAVE_PAM=yes:" \
		-e "s:HAVE_SLN=no:HAVE_SLN=yes:" \
		-e "s:HAVE_TSORT=no:HAVE_TSORT=yes:" \
		-e "s:usr/man:usr/share/man:" \
		-e "s:usr/info:usr/share/info:" \
			MCONFIG.orig > MCONFIG
}

src_compile() {
	./configure || die

	if [ -z "`use nls`" ]
	then
		cp defines.h defines.h.orig	
		cp Makefile Makefile.orig
		
		sed -e "s/#define ENABLE_NLS//g" \
			-e "s/#define HAVE_libintl_h//g" \
			defines.h.orig > defines.h
	
		sed "s/\(^SUBDIRS=\)po/\1lib/g" \
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
