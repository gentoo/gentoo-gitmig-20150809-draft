# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/pmake/pmake-1.45-r2.ebuild,v 1.5 2003/04/27 12:18:11 azarah Exp $

IUSE=""

inherit eutils
EPATCH_SOURCE="${FILESDIR}"
EPATCH_SUFFIX="patch"

MY_P="${PN}_${PV}-11"
S="${WORKDIR}/${P}"

DESCRIPTION="BSD build tool to create programs in parallel"
HOMEPAGE="http://www.netbsd.org/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="BSD"

SLOT="0"

KEYWORDS="x86 ~alpha"

DEPEND="virtual/glibc"
#RDEPEND=""

src_unpack() {
	unpack ${A}
	
	cd ${S}
	# We do not want all patches in ${FILESDIR}, as 01_all_groffpatch.patch is
	# not longer valid for this version.
	epatch ${FILESDIR}/02_all_mktemp.patch
	
	mv Makefile.boot Makefile.bootorig
	sed 's/MACHINE=sun/MACHINE=gentoo/g' Makefile.bootorig > Makefile.bootor
	use x86 && sed 's/MACHINE_ARCH=sparc/MACHINE_ARCH=i386/g' Makefile.bootor > Makefile.boot
	use alpha && sed 's/MACHINE_ARCH=sparc/MACHINE_ARCH=alpha/g' Makefile.bootor > Makefile.boot
	use ppc && sed 's/MACHINE_ARCH=sparc/MACHINE_ARCH=ppc/g' Makefile.bootor > Makefile.boot
	use sparc64 && sed 's/MACHINE_ARCH=sparc/MACHINE_ARCH=sparc64/g' Makefile.bootor > Makefile.boot
}

src_compile() {
	make -f Makefile.boot  CFLAGS="-O2 -g -Wall -D_GNU_SOURCE  -D__COPYRIGHT\(x\)= -D__RCSID\(x\)= -I."
}

src_install() {
	dodir /usr/share/mk
	insinto /usr/share/mk
	rm -f mk/*~
	doins mk/*

	mv bmake pmake
	dobin pmake
	dobin mkdep
	mv make.1 pmake.1
	doman mkdep.1 pmake.1
	dodoc PSD.doc/tutorial.ms

}
