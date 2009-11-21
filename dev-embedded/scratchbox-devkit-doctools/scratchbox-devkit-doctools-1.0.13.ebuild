# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/scratchbox-devkit-doctools/scratchbox-devkit-doctools-1.0.13.ebuild,v 1.2 2009/11/21 14:33:51 ayoy Exp $

SBOX_GROUP="sbox"
RESTRICT="strip binchecks"

DESCRIPTION="A cross-compilation toolkit designed to make embedded Linux application development easier."
HOMEPAGE="http://www.scratchbox.org/"
SRC_URI="http://scratchbox.org/download/files/sbox-releases/stable/tarball/${P}-i386.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-embedded/scratchbox-1.0*"
DEPEND=""

TARGET_DIR="/opt/scratchbox"

S=${WORKDIR}/scratchbox

src_install() {
	dodir ${TARGET_DIR}
	cp -pRP * "${D}/${TARGET_DIR}"
}
