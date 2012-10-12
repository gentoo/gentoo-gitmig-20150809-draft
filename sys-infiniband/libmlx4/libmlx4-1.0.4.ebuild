# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libmlx4/libmlx4-1.0.4.ebuild,v 1.1 2012/10/12 13:19:34 alexxy Exp $

EAPI="4"

OFED_VER="3.5-rc2"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB userspace driver for Mellanox ConnectX HCA"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-infiniband/libibverbs:${SLOT}
	"
RDEPEND="
		!sys-infiniband/openib-userspace"
block_other_ofed_versions
