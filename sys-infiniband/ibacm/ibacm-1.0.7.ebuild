# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/ibacm/ibacm-1.0.7.ebuild,v 1.1 2012/10/12 13:19:36 alexxy Exp $

EAPI="4"

OFED_VER="3.5-rc2"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="IB CM pre-connection service application"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

RDEPEND="sys-infiniband/libibverbs:${SLOT}"
DEPEND="${RDEPEND}"
block_other_ofed_versions
