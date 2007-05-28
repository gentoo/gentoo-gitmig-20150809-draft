# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnat-gcc/gnat-gcc-3.4.6.ebuild,v 1.5 2007/05/28 19:21:12 george Exp $

inherit gnatbuild

DESCRIPTION="GNAT Ada Compiler - gcc version"
HOMEPAGE="http://gcc.gnu.org/"
LICENSE="GMGPL"

# BOOT_SLOT is defined in gnatbuild.eclass and depends only on $PV
SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${PV}/gcc-core-${PV}.tar.bz2
	ftp://gcc.gnu.org/pub/gcc/releases/gcc-${PV}/gcc-ada-${PV}.tar.bz2
	ppc?   ( mirror://gentoo/gnatboot-${BOOT_SLOT}-ppc.tar.bz2 )
	x86?   ( mirror://gentoo/gnatboot-${BOOT_SLOT}-i386.tar.bz2 )
	amd64? ( mirror://gentoo/gnatboot-${BOOT_SLOT}-amd64-r2.tar.bz2 )"

KEYWORDS="~amd64 ~x86"

QA_EXECSTACK="${BINPATH:1}/gnatls ${BINPATH:1}/gnatbind ${BINPATH:1}/gnatmake
	${LIBEXECPATH:1}/gnat1 ${LIBPATH:1}/adalib/libgnat-${SLOT}.so"

src_unpack() {
	gnatbuild_src_unpack

	#fixup some hardwired flags
	cd ${S}/gcc/ada
	sed -i -e "s:CFLAGS = -O2:CFLAGS = ${CFLAGS}:"	\
		Makefile.adalib || die "patching Makefile.adalib failed"
}
