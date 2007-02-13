# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bfin-toolchain/bfin-toolchain-2006.2_rc2.ebuild,v 1.2 2007/02/13 17:46:23 vapier Exp $


DESCRIPTION="toolchain for Blackfin processors"
HOMEPAGE="http://blackfin.uclinux.org/"
SRC_URI="
	amd64? (
		http://blackfin.uclinux.org/gf/download/frsrelease/329/2493/blackfin-toolchain-06r2-5.x86_64.tar.gz
		http://blackfin.uclinux.org/gf/download/frsrelease/329/2499/blackfin-toolchain-gcc-3.4-addon-06r2-5.x86_64.tar.gz
		http://blackfin.uclinux.org/gf/download/frsrelease/329/2495/blackfin-toolchain-elf-gcc-3.4-addon-06r2-5.x86_64.tar.gz
		http://blackfin.uclinux.org/gf/download/frsrelease/329/2497/blackfin-toolchain-elf-gcc-4.1-06r2-5.x86_64.tar.gz
	)
	ia64? (
		http://blackfin.uclinux.org/gf/download/frsrelease/329/2468/blackfin-toolchain-06r2-5.ia64.tar.gz
		http://blackfin.uclinux.org/gf/download/frsrelease/329/2474/blackfin-toolchain-gcc-3.4-addon-06r2-5.ia64.tar.gz
		http://blackfin.uclinux.org/gf/download/frsrelease/329/2470/blackfin-toolchain-elf-gcc-3.4-addon-06r2-5.ia64.tar.gz
		http://blackfin.uclinux.org/gf/download/frsrelease/329/2472/blackfin-toolchain-elf-gcc-4.1-06r2-5.ia64.tar.gz
	)
	ppc? (
		http://blackfin.uclinux.org/gf/download/frsrelease/329/2476/blackfin-toolchain-06r2-5.ppc.tar.gz
		http://blackfin.uclinux.org/gf/download/frsrelease/329/2481/blackfin-toolchain-gcc-3.4-addon-06r2-5.ppc.tar.gz
		http://blackfin.uclinux.org/gf/download/frsrelease/329/2478/blackfin-toolchain-elf-gcc-3.4-addon-06r2-5.ppc.tar.gz
		http://blackfin.uclinux.org/gf/download/frsrelease/329/2482/blackfin-toolchain-elf-gcc-4.1-06r2-5.ppc.tar.gz
	)
	x86? (
		http://blackfin.uclinux.org/gf/download/frsrelease/329/1151/blackfin-toolchain-06r2-5.i386.tar.gz
		http://blackfin.uclinux.org/gf/download/frsrelease/329/1152/blackfin-toolchain-gcc-3.4-addon-06r2-5.i386.tar.gz
		http://blackfin.uclinux.org/gf/download/frsrelease/329/1153/blackfin-toolchain-elf-gcc-3.4-addon-06r2-5.i386.tar.gz
		http://blackfin.uclinux.org/gf/download/frsrelease/329/1154/blackfin-toolchain-elf-gcc-4.1-06r2-5.i386.tar.gz
	)
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE=""
RESTRICT="strip"

DEPEND=""

S=${WORKDIR}

src_install() {
	mv "${S}"/opt "${D}"/ || die
}
