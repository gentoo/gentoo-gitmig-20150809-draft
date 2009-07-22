# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/clvm/clvm-2.02.45.ebuild,v 1.1 2009/07/22 01:02:25 robbat2 Exp $

EAPI=2
DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/lvm2/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=sys-fs/lvm2-2.02.45[clvm]"

clvm_warning() {
	elog "clvm has been merged with the main lvm2 package."
	elog "please remove any explicit references to sys-fs/clvm."
}

pkg_setup() {
	clvm_warning
}
pkg_postinst() {
	clvm_warning
}
