# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/uclibc/uclibc-0.9.25.ebuild,v 1.1 2004/01/03 17:58:59 vapier Exp $

inherit eutils

MY_P="${P/ucl/uCl}"
DESCRIPTION="C library for developing embedded Linux systems"
HOMEPAGE="http://www.uclibc.org/"
SRC_URI="http://www.kernel.org/pub/linux/libs/uclibc/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips"

DEPEND="sys-devel/gcc"
PROVIDE="virtual/glibc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	# fixup for install perms
	sed -i -e "s:-fa:-dRf:g" Makefile

	make defconfig || die "could not config"
	for def in UCLIBC_{HAS_LOCALE,PROFILING} DO{DEBUG,ASSERTS} SUPPORT_LD_DEBUG{,_EARLY} ; do
		sed -i "s:${def}=y:# ${def} is not set:" .config
	done
	cp .config myconfig

	emake clean || die "could not clean"
}

src_compile() {
	mv myconfig .config
	emake -j1 || die "could not make"
}

src_install() {
	emake PREFIX=${D} install || die "install failed"
}
