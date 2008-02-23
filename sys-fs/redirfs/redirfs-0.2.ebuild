# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/redirfs/redirfs-0.2.ebuild,v 1.1 2008/02/23 10:29:19 alonbl Exp $

inherit linux-mod

DESCRIPTION="Redirecting FileSystem"
HOMEPAGE="http://www.redirfs.org"
SRC_URI="http://www.redirfs.org/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_setup() {
	linux-mod_pkg_setup
	MODULE_NAMES="redirfs(misc:)"
	BUILD_TARGETS="redirfs.ko"
	BUILD_PARAMS="
		KERN_SRC=${KERNEL_DIR}
		KERN_VER=${KV_MAJOR}.${KV_MINOR}"
}

src_install() {
	linux-mod_src_install
	insinto /usr/include
	doins redirfs.h
}
