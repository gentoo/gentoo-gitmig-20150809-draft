# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bfin-toolchain/bfin-toolchain-2009.1_rc10.ebuild,v 1.1 2009/10/04 00:13:49 vapier Exp $

# this should skip pointless scanelf checks on the target libs
CTARGET="bfin"

inherit rpm

DESCRIPTION="toolchain for Blackfin processors"
HOMEPAGE="http://blackfin.uclinux.org/"
FRS_ID="449"
BASE_URI="http://blackfin.uclinux.org/gf/download/frsrelease/${FRS_ID}"
MY_PN="blackfin-toolchain"
MY_PV=${PV#20}
MY_PV=${MY_PV/./r}
MY_PV=${MY_PV/_rc/-}
src_uri() {
	local arch=$1
	echo ${BASE_URI}/$2/${MY_PN}-${MY_PV}.${arch}.tar.bz2
	echo ${BASE_URI}/$3/${MY_PN}-elf-gcc-4.1-${MY_PV}.${arch}.tar.bz2
	echo ${BASE_URI}/$4/${MY_PN}-uclibc-default-${MY_PV}.${arch}.tar.bz2
	echo ${BASE_URI}/$5/blackfin-jtag-tools-${MY_PV}.${arch}.tar.bz2
}
SRC_URI="
	amd64? ( $(src_uri x86_64 6862 6864 6870 6860) )
	x86?   ( $(src_uri i386   6843 6845 6848 6841) )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="=sys-libs/readline-5*"

S=${WORKDIR}

src_install() {
	mv "${S}"/opt "${D}"/ || die
}
