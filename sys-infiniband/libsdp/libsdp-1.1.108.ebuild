# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libsdp/libsdp-1.1.108.ebuild,v 1.2 2011/07/02 20:30:15 alexxy Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="0.15.gd7fdb72"
OFED_SNAPSHOT="1"

inherit openib

DESCRIPTION="Socket Direct Protocol for unmodified applications"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	>=sys-infiniband/libibverbs-1.1.4
	"
RDEPEND="${DEPEND}"
