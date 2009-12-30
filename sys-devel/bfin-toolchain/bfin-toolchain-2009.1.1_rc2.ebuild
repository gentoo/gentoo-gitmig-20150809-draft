# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bfin-toolchain/bfin-toolchain-2009.1.1_rc2.ebuild,v 1.1 2009/12/30 04:49:52 vapier Exp $

# this should skip pointless scanelf checks on the target libs
CTARGET="bfin"

inherit rpm

DESCRIPTION="toolchain for Blackfin processors"
HOMEPAGE="http://blackfin.uclinux.org/"
FRS_ID="470"
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
	amd64? ( $(src_uri x86_64 7330 7332 7338 7328) )
	x86?   ( $(src_uri i386   7316 7317 7320 7315) )
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
