# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/redirfs/redirfs-0.6.ebuild,v 1.1 2009/02/22 12:53:54 carlo Exp $

inherit linux-mod

DESCRIPTION="The RedirFS or redirecting file system is a new layer between virtual file system switch (VFS) and file system drivers."
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
	BUILD_PARAMS="-C ${KERNEL_DIR} M=${S} modules"
	ewarn "This package is EXPERIMENTAL use it at your own risk"
	sleep 5
}

src_install() {
	dodoc CHANGELOG INSTALL README TODO
	linux-mod_src_install
	insinto /usr/include
	doins redirfs.h
}
