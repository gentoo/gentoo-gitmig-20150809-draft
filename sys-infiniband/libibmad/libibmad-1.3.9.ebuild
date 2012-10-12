# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libibmad/libibmad-1.3.9.ebuild,v 1.1 2012/10/12 13:19:35 alexxy Exp $

EAPI="4"

OFED_VER="3.5-rc2"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB library providing low layer IB functions for use by the IB diagnostic/management programs"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-infiniband/libibumad:${SLOT}
	"
RDEPEND="${DEPEND}"
block_other_ofed_versions
