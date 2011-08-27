# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/rds-tools/rds-tools-2.0.4.ebuild,v 1.3 2011/08/27 19:46:47 xarthisius Exp $

EAPI=4

OFED_VER="1.5.3.1"
OFED_SUFFIX="1"

inherit base openib toolchain-funcs

DESCRIPTION="OpenIB userspace rds-tools"

KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND=">=sys-infiniband/libibverbs-1.1.4"
RDEPEND="${DEPEND}
	!sys-infiniband/openib-userspace"

DOCS=( README )
PATCHES=( "${FILESDIR}"/${P}-qa.patch )

pkg_setup() {
	tc-export CC
}
