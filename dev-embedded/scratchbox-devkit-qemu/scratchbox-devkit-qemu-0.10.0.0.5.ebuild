# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/scratchbox-devkit-qemu/scratchbox-devkit-qemu-0.10.0.0.5.ebuild,v 1.2 2009/11/21 14:37:24 ayoy Exp $

SBOX_GROUP="sbox"
RESTRICT="strip binchecks"

MYPV=0.10.0-0sb5
MYP=${PN}-${MYPV}

DESCRIPTION="A cross-compilation toolkit designed to make embedded Linux application development easier."
HOMEPAGE="http://www.scratchbox.org/"
SRC_URI="http://scratchbox.org/download/files/sbox-releases/stable/tarball/${MYP}-i386.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-embedded/scratchbox-1.0*"
RDEPEND=""

TARGET_DIR="/opt/scratchbox"

S=${WORKDIR}/scratchbox

src_install() {
	dodir ${TARGET_DIR}
	cp -pRP * "${D}/${TARGET_DIR}"
}
