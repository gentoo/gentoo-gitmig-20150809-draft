# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/clean/clean-2.0.1.ebuild,v 1.11 2004/07/14 13:36:37 agriffis Exp $

DESCRIPTION="Clean"
HOMEPAGE="http://www.cs.kun.nl/~clean/"
SRC_URI="http://www.cs.kun.nl/~clean/download/Clean20/linux/Clean2.0.1.tar.gz http://www.cs.kun.nl/~clean/download/Clean20/source/Clean${PV}Sources.tar.gz"

LICENSE="LGPL-2.1 | clean"
SLOT="0"
KEYWORDS="s390 x86 -ppc -sparc"
IUSE=""

DEPEND="virtual/libc"
S="${WORKDIR}/Clean 2.0.1 Sources"

src_unpack() {
	unpack Clean2.0.1.tar.gz
	unpack Clean${PV}Sources.tar.gz

	cd clean ; make
}

src_compile() {
	cd "${S}"
	export PATH=$PATH:${WORKDIR}/clean/bin
	cd CleanTools/clm ; make -f Makefile.linux || die ; cd -
	cd CodeGenerator ; make -f Makefile.linux || die ; cd -
	cd Compiler ; sh make.linux.sh || die ; cd -
}

src_install () {
	cd "${S}"

	dodir /usr/share/clean/exe
	exeinto /usr/share/clean/exe
	doexe Compiler/cocl
	doexe CodeGenerator/cg

	dodir /usr/bin
	dobin CleanTools/clm/clm

	dodir /usr/share/clean/iolib
	insinto /usr/share/clean/iolib

	dodoc "Clean2.0.1LicenseConditions.txt"
}
