# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cdfs/cdfs-2.6.18.ebuild,v 1.1 2006/11/23 16:04:22 drizzt Exp $

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

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
}
