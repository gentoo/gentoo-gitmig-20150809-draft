# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/uclibc/uclibc-0.9.16.ebuild,v 1.3 2003/02/13 10:52:09 vapier Exp $

MY_P="${P/ucl/uCl}"
DESCRIPTION="C library for developing embedded Linux systems"
HOMEPAGE="http://www.uclibc.org/"
SRC_URI="http://www.kernel.org/pub/linux/libs/uclibc/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
PROVIDE="virtual/glibc"

DEPEND="sys-devel/gcc"

S="${WORKDIR}/${MY_P}"

src_compile() {
	make allyesconfig || die "could not config"

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
	patch -p0 < ${FILESDIR}/Makefile-cp-order-fix.patch || die
	make PREFIX=${D} install || die "install failed"
}
