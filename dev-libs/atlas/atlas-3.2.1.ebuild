# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/atlas/atlas-3.2.1.ebuild,v 1.9 2003/09/06 22:29:24 msterret Exp $

DESCRIPTION="Automatically Tuned Linear Algebra Software (BLAS implementation)"
HOMEPAGE="http://math-atlas.sourceforge.net/"
SRC_URI="http://www.netlib.org/atlas/${PN}${PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/glibc"

S=${WORKDIR}/ATLAS

src_compile() {

#Make is actually an interactive configuration step.
#The configuration is highly sensitive to your specific machine.
#Although it is quite good, it will default to accuracy over speed.
#Powertweakers might want to configure interactively (also for cross-compile)
# by uncommenting the next line and commenting the yes ""| make || die line .
#	make || die

#atlas will automatically do a parallel make if possible.
	yes "" | make || die

#Let's go grab the architecture determined by the configure
	cd ${S}/bin

#There might be a better way to do this!?!
#We can assume "Linux" for a Gentoo Linux system.
#Need ATLAS_ARCH in src_install too.
	ATLAS_ARCH=$(ls -d Linux*)

	cd ${S}
#This doesn't install into the live / file system.
#It installs into ${S}/lib/Linux*
	make install arch=${ATLAS_ARCH} || die

}

src_install () {

	cd ${S}/lib/${ATLAS_ARCH}

	insinto /usr/lib
	dolib.a libatlas.a libcblas.a libf77blas.a libtstatlas.a

#the atlas liblapack.a library is not a complete lapack library,
#just the atlas optimizable objects.  Store it some place safe
#where we can grab it when building the complete lapack library.
	insinto /usr/share/${PN}
	doins liblapack.a

	cd ${S}/include/${ATLAS_ARCH}

	insinto /usr/include
	doins *.h

	cd ${S}

	dodoc README INSTALL.txt
	dodoc doc/*.txt
	insinto /usr/share/doc/${P}/ps
	doins doc/*.ps
	dodoc bin/${ATLAS_ARCH}/INSTALL_LOG/SUMMARY.LOG
}
