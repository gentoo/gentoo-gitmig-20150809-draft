# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/scratchbox-toolchain-cs2009q1/scratchbox-toolchain-cs2009q1-1.0.13.ebuild,v 1.1 2009/12/24 12:49:31 ayoy Exp $

SBOX_GROUP="sbox"

MY_PV="203sb1-${PV}-2-i386"

DESCRIPTION="A cross-compilation toolkit designed to make embedded Linux application development easier."
HOMEPAGE="http://www.scratchbox.org/"
SRC_URI="http://scratchbox.org/download/files/sbox-releases/stable/tarball/${PN/cs2009q1/arm-linux-cs2009q1}-${MY_PV}.tar.gz
	http://scratchbox.org/download/files/sbox-releases/stable/tarball/${PN/cs2009q1/i486-linux-cs2009q1}-${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="=dev-embedded/scratchbox-1.0*"

TARGET_DIR="/opt/scratchbox"

RESTRICT="strip"

S=${WORKDIR}/scratchbox

src_install() {
	dodir ${TARGET_DIR}
	cp -pRP * "${D}/${TARGET_DIR}"
}
