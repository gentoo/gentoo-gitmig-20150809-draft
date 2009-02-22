# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bfin-toolchain/bfin-toolchain-2008.1.5_rc14.ebuild,v 1.2 2009/02/22 13:22:19 flameeyes Exp $

DESCRIPTION="toolchain for Blackfin processors"
HOMEPAGE="http://blackfin.uclinux.org/"
BASE_URI="http://blackfin.uclinux.org/gf/download/frsrelease/392"
MY_PN="blackfin-toolchain"
MY_PV="08r1.5-14"
src_uri() {
	local arch=$1
	echo ${BASE_URI}/$2/${MY_PN}-${MY_PV}.${arch}.tar.bz2
	echo ${BASE_URI}/$3/${MY_PN}-elf-gcc-4.1-${MY_PV}.${arch}.tar.bz2
	echo ${BASE_URI}/$4/${MY_PN}-uclibc-default-${MY_PV}.${arch}.tar.bz2
	echo ${BASE_URI}/$5/blackfin-jtag-tools-${MY_PV}.${arch}.tar.bz2
}
SRC_URI="
	amd64? ( $(src_uri x86_64 5132 5133 5145 5138) )
	ia64?  ( $(src_uri ia64   5155 5160 5159 5147) )
	ppc?   ( $(src_uri ppc    5200 5199 5196 5148) )
	x86?   ( $(src_uri i386   5087 5080 5075 5081) )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="=sys-libs/readline-5*"

S=${WORKDIR}

src_install() {
	mv "${S}"/opt "${D}"/ || die
}
