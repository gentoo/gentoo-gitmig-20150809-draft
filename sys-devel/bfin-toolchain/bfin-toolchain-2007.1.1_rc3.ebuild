# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bfin-toolchain/bfin-toolchain-2007.1.1_rc3.ebuild,v 1.2 2009/12/30 04:46:44 vapier Exp $

DESCRIPTION="toolchain for Blackfin processors"
HOMEPAGE="http://blackfin.uclinux.org/"
SRC_URI="
	http://blackfin.uclinux.org/gf/download/frsrelease/348/3347/blackfin-toolchain-07r1.1-3.i386.tar.gz
	http://blackfin.uclinux.org/gf/download/frsrelease/348/3348/blackfin-toolchain-elf-gcc-3.4-addon-07r1.1-3.i386.tar.gz
	http://blackfin.uclinux.org/gf/download/frsrelease/348/3351/blackfin-toolchain-elf-gcc-4.1-07r1.1-3.i386.tar.gz
	http://blackfin.uclinux.org/gf/download/frsrelease/348/3349/blackfin-toolchain-gcc-3.4-addon-07r1.1-3.i386.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="strip"

S=${WORKDIR}

src_install() {
	mv "${S}"/opt "${D}"/ || die
}
