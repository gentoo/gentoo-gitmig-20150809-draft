# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bfin-toolchain/bfin-toolchain-2008.1_rc8.ebuild,v 1.1 2008/05/02 21:33:15 vapier Exp $

DESCRIPTION="toolchain for Blackfin processors"
HOMEPAGE="http://blackfin.uclinux.org/"
BASE_URI="http://blackfin.uclinux.org/gf/download/frsrelease/375"
SRC_URI="
	amd64? (
		${BASE_URI}/4308/blackfin-toolchain-08r1-8.x86_64.tar.gz
		${BASE_URI}/4312/blackfin-toolchain-elf-gcc-4.1-08r1-8.x86_64.tar.gz
		${BASE_URI}/4307/blackfin-toolchain-uclibc-default-08r1-8.x86_64.tar.gz
	)
	ia64? (
		${BASE_URI}/4265/blackfin-toolchain-08r1-8.ia64.tar.gz
		${BASE_URI}/4267/blackfin-toolchain-elf-gcc-4.1-08r1-8.ia64.tar.gz
		${BASE_URI}/4261/blackfin-toolchain-uclibc-default-08r1-8.ia64.tar.gz
	)
	ppc? (
		${BASE_URI}/4269/blackfin-toolchain-08r1-8.ppc.tar.gz
		${BASE_URI}/4284/blackfin-toolchain-elf-gcc-4.1-08r1-8.ppc.tar.gz
		${BASE_URI}/4288/blackfin-toolchain-uclibc-default-08r1-8.ppc.tar.gz
	)
	x86? (
		${BASE_URI}/4037/blackfin-toolchain-08r1-8.i386.tar.gz
		${BASE_URI}/4042/blackfin-toolchain-elf-gcc-4.1-08r1-8.i386.tar.gz
		${BASE_URI}/4041/blackfin-toolchain-uclibc-default-08r1-8.i386.tar.gz
	)
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""
RESTRICT="strip"

DEPEND=""

S=${WORKDIR}

src_install() {
	mv "${S}"/opt "${D}"/ || die
}
