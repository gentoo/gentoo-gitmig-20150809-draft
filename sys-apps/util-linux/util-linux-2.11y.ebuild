# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.11y.ebuild,v 1.10 2003/05/25 15:26:46 mholzer Exp $

IUSE="crypt nls"

inherit eutils flag-o-matic

filter-flags -fPIC

CRYPT_PATCH_P="${P}-crypt-gentoo"
S="${WORKDIR}/${P}"
DESCRIPTION="Various useful Linux utilities"
SRC_URI="mirror://kernel/linux/utils/${PN}/${P}.tar.bz2
	crypt? ( http://gentoo.twobit.net/misc/${CRYPT_PATCH_P}.patch.gz )"
# Patched for 2.11y -- NJ <carpaski@gentoo.org)
#	crypt? ( http://www.kernel.org/pub/linux/kernel/people/hvr/util-linux-patch-int/${CRYPT_PATCH_P}.patch.gz )"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"

KEYWORDS="x86 ppc sparc alpha hppa"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r2
	sys-apps/pam-login"

RDEPEND="${DEPEND} dev-lang/perl
	nls? ( sys-devel/gettext )"


src_unpack() {
	unpack ${A}

	cd ${S}

	if [ ! -z "`use crypt`" ]
	then
		epatch ${DISTDIR}/${CRYPT_PATCH_P}.patch.gz
	fi

	# Fix rare failures with -j4 or higher
	epatch ${FILESDIR}/${P}-parallel-make.patch

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

	./configure || die "config"

	if [ -z "`use nls`" ]
	then
		cp defines.h defines.h.orig	
		grep -v "ENABLE_NLS" \
			defines.h.orig > defines.h
		cp defines.h defines.h.orig
		grep -v "HAVE_libintl_h" \
			defines.h.orig > defines.h

		cp Makefile Makefile.orig
		sed -e "s:SUBDIRS=po \\\:SUBDIRS= \\\:g" \
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

