# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/scratchbox-toolchain-cs2007q3-glibc2_5/scratchbox-toolchain-cs2007q3-glibc2_5-1.0.11.ebuild,v 1.1 2009/05/06 20:20:34 tester Exp $

SBOX_GROUP="sbox"
RESTRICT="strip binchecks"

ARMV=${PV}-7
I486V=${PV}-5

DESCRIPTION="A cross-compilation toolkit designed to make embedded Linux application development easier."
HOMEPAGE="http://www.scratchbox.org/"
SRC_URI="http://scratchbox.org/download/files/sbox-releases/stable/tarball/${PN/_/.}-arm7-${ARMV}-i386.tar.gz
	http://scratchbox.org/download/files/sbox-releases/stable/tarball/${PN/_/.}-i486-${I486V}-i386.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="=dev-embedded/scratchbox-1.0*"

TARGET_DIR="/opt/scratchbox"

S=${WORKDIR}/scratchbox

src_install() {
	dodir ${TARGET_DIR}
	cp -pRP * "${D}/${TARGET_DIR}"
}
