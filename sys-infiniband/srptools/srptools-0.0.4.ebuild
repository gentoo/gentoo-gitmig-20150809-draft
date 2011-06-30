# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/srptools/srptools-0.0.4.ebuild,v 1.1 2011/06/30 21:15:58 alexxy Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="0.1.gce1f64c"
OFED_SNAPSHOT="1"

inherit openib

DESCRIPTION="Tools for discovering and connecting to SRP CSI targets on InfiniBand fabrics"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=sys-infiniband/libibverbs-1.1.4
	>=sys-infiniband/libibumad-1.3.7
	"
RDEPEND="${DEPDND}"
