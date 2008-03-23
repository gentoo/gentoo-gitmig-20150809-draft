# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/redirfs/redirfs-0.2-r1.ebuild,v 1.2 2008/03/23 21:31:54 robbat2 Exp $

inherit linux-mod eutils

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
	BUILD_PARAMS=" \
		KERN_SRC=\"${KERNEL_DIR}\" \
		KERN_VER=${KV_MAJOR}.${KV_MINOR}"

	eerror "This package is EXPERIMENTAL use it at your own risk"
	sleep 5
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-truncate_inode_pages.patch"
}

src_install() {
	dodoc CHANGELOG INSTALL README TODO
	linux-mod_src_install
	insinto /usr/include
	doins redirfs.h
}
