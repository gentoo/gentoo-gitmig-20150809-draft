# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bfin-toolchain/bfin-toolchain-2006.2_rc2.ebuild,v 1.1 2006/11/11 00:28:15 vapier Exp $

inherit rpm

DESCRIPTION="Compiler for Blackfin targets"
HOMEPAGE="http://blackfin.uclinux.org/"
SRC_URI="http://blackfin.uclinux.org/frs/download.php/1136/blackfin-toolchain-06r2-5.i386.rpm
	http://blackfin.uclinux.org/frs/download.php/1139/blackfin-toolchain-gcc-3.4-addon-06r2-5.i386.rpm
	bfin-elf? (
		http://blackfin.uclinux.org/frs/download.php/1137/blackfin-toolchain-elf-gcc-3.4-addon-06r2-5.i386.rpm
		http://blackfin.uclinux.org/frs/download.php/1138/blackfin-toolchain-elf-gcc-4.1-06r2-5.i386.rpm
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="bfin-elf"
RESTRICT="strip"

DEPEND=""

S=${WORKDIR}

src_install() {
	mv "${S}"/opt "${D}"/ || die
}
