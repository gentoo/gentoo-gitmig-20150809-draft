# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libibverbs/libibverbs-1.1.6.ebuild,v 1.1 2012/10/12 13:19:35 alexxy Exp $

EAPI="4"

OFED_VER="3.5-rc2"
OFED_SUFFIX="1"

inherit eutils openib

DESCRIPTION="A library allowing programs to use InfiniBand 'verbs' for direct access to IB hardware"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	!sys-infiniband/openib-userspace"
block_other_ofed_versions
