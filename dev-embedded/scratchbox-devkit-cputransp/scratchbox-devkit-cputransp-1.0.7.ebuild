# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/scratchbox-devkit-cputransp/scratchbox-devkit-cputransp-1.0.7.ebuild,v 1.1 2009/05/06 19:34:04 tester Exp $

SBOX_GROUP="sbox"
RESTRICT="strip binchecks"

DESCRIPTION="A cross-compilation toolkit designed to make embedded Linux application development easier."
HOMEPAGE="http://www.scratchbox.org/"
SRC_URI="http://scratchbox.org/download/files/sbox-releases/stable/tarball/${P}-i386.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="=dev-embedded/scratchbox-1.0*"
RDEPEND=""

TARGET_DIR="/opt/scratchbox"

S=${WORKDIR}/scratchbox

src_install() {
	dodir ${TARGET_DIR}
	cp -pRP * "${D}/${TARGET_DIR}"
}
