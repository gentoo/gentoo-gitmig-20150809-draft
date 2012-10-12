# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/dapl/dapl-2.0.36.ebuild,v 1.1 2012/10/12 13:19:36 alexxy Exp $

EAPI="4"

OFED_VER="3.5-rc2"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB - Direct Access Provider Library"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-infiniband/libibverbs:${SLOT}
		sys-infiniband/librdmacm:${SLOT}"
RDEPEND="${DEPEND}
		!sys-infiniband/openib-userspace"

block_other_ofed_versions
