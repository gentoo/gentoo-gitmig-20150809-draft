# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/atlas/atlas-3.4.1.ebuild,v 1.1 2003/03/13 08:30:12 george Exp $

IUSE=""

S="${WORKDIR}/ATLAS"
DESCRIPTION="automatically tuned linear algebra software"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/math-atlas/${PN}${PV}.tar.bz2"
HOMEPAGE="http://math-atlas.sourceforge.net"

KEYWORDS="~x86 ~sparc"
LICENSE="BSD"
#not sure if this is a best choice, as this is a lib,
#but setting SLOT to 0, following previous version
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	# create a file answer to be redirected to make
	echo "023" > answer
	echo "" >> answer
	echo "" >> answer
	echo "" >> answer
	echo "" >> answer
	# the architecture of the processor is determined from the CFLAGS
	case $CFLAGS in
		*athlon*)
			echo "AMD Athlon Processor Identified"
			echo 2 >> answer;;
		*pentiumpro*)
			echo "Pentium Pro Processor Identified"
			echo 3 >> answer;;
		*pentium2*)
			echo "Pentium II Processor Identified"
			echo 4 >> answer;;
		*pentium3*)
			echo "Pentium III Processor Identified"
			echo 5 >> answer;;
		*pentium4*)
			echo "Pentium IV Processor Identified"
			echo 6 >> answer;;
		*)
			echo "Unknown Processor"
			echo 1 >> answer;;
	esac
	echo "" >> answer
	echo "" >> answer
	echo "" >> answer
	echo "" >> answer
	echo "" >> answer
	echo "" >> answer
	echo "" >> answer

	make < answer || die
	TMPSTR=$(ls Make.Linux*)
	ATLAS_ARCH=${TMPSTR#'Make.'}
	make install arch=${ATLAS_ARCH} || die
}

src_install () {
	# almost completely copied from the atlas-3.2.1-r1 ebuild
	cd ${S}/lib/${ATLAS_ARCH}

	insinto /usr/lib
	dolib.a libatlas.a libcblas.a libf77blas.a liblapack.a

	cd ${S}/include
	insinto /usr/include
	doins cblas.h clapack.h

	cd ${S}

	dodoc README INSTALL.txt
	dodoc doc/*.txt
	insinto /usr/share/doc/${PN}-${PV}
	doins doc/*.ps
	dodoc bin/${ATLAS_ARCH}/INSTALL_LOG/SUMMARY.LOG
}
