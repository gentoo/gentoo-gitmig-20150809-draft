# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/scratchbox-devkit-git/scratchbox-devkit-git-1.0.1.ebuild,v 1.3 2009/11/30 11:06:32 flameeyes Exp $

SBOX_GROUP="sbox"

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

QA_TEXTRELS="opt/scratchbox"

S=${WORKDIR}/scratchbox

src_install() {
	dodir ${TARGET_DIR}
	cp -pRP * "${D}/${TARGET_DIR}"
}
