# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/scratchbox-toolchain-cs2005q3_2-glibc2_5/scratchbox-toolchain-cs2005q3_2-glibc2_5-1.0.7.ebuild,v 1.2 2009/11/21 14:39:13 ayoy Exp $

SBOX_GROUP="sbox"
RESTRICT="strip binchecks"

ARMV=${PV}
I386V=${PV}.2

DESCRIPTION="A cross-compilation toolkit designed to make embedded Linux application development easier."
HOMEPAGE="http://www.scratchbox.org/"
SRC_URI="http://scratchbox.org/download/files/sbox-releases/stable/tarball/${PN/cs2005q3_2-glibc2_5/cs2005q3.2-glibc2.5}-arm-${PV}.2-i386.tar.gz
	http://scratchbox.org/download/files/sbox-releases/stable/tarball/${PN/cs2005q3_2-glibc2_5/cs2005q3.2-glibc2.5}-i386-${PV}-i386.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="=dev-embedded/scratchbox-1.0*"

TARGET_DIR="/opt/scratchbox"

S=${WORKDIR}/scratchbox

src_install() {
	dodir ${TARGET_DIR}
	cp -pRP * "${D}/${TARGET_DIR}"
}
