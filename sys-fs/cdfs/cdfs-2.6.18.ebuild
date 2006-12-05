# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cdfs/cdfs-2.6.18.ebuild,v 1.2 2006/12/05 17:14:58 drizzt Exp $

inherit linux-mod

DESCRIPTION="A file system for Linux systems that 'exports' all tracks and boot images on a CD as normal files."
HOMEPAGE="http://www.elis.rug.ac.be/~ronsse/cdfs/"
SRC_URI="http://www.elis.rug.ac.be/~ronsse/cdfs/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPENDS=""
DEPENDS=""

MODULE_NAMES="cdfs(extra)"
CONFIG_CHECK="BLK_DEV_LOOP"
BUILD_TARGETS="all"

src_unpack() {
	unpack ${A}
	cd "${S}"
	kernel_is ge 2 6 19 && epatch "${FILESDIR}"/${P}-kernel-2.6.19.patch
}

src_compile() {
	set_arch_to_kernel

	emake KDIR="${KERNEL_DIR}" || die 'emake failed'
}
