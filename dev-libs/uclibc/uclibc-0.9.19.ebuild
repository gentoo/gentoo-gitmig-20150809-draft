# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/uclibc/uclibc-0.9.19.ebuild,v 1.1 2003/06/20 03:55:14 vapier Exp $

inherit eutils

MY_P="${P/ucl/uCl}"
DESCRIPTION="C library for developing embedded Linux systems"
HOMEPAGE="http://www.uclibc.org/"
SRC_URI="http://www.kernel.org/pub/linux/libs/uclibc/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-devel/gcc"
PROVIDE="virtual/glibc"

S=${WORKDIR}/${MY_P}

src_compile() {
	make defconfig || die "could not config"

	for def in UCLIBC_HAS_LOCALE DODEBUG DOASSERTS SUPPORT_LD_DEBUG SUPPORT_LD_DEBUG_EARLY ; do
		sed -e "s:${def}=y:# ${def} is not set:" \
			.config > myconfig
		cp myconfig .config
	done

	emake clean || die "could not clean"
	mv myconfig .config
	make || die "could not make"
}

src_install() {
	epatch ${FILESDIR}/Makefile-cp-order-fix.patch
	make PREFIX=${D} install || die "install failed"
}
