# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libmlx4/libmlx4-1.0.1.ebuild,v 1.3 2011/07/26 13:19:25 ulm Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="1.18.gb810a27"
OFED_SNAPSHOT="1"

inherit openib

DESCRIPTION="OpenIB userspace driver for Mellanox ConnectX HCA"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	>=sys-infiniband/libibverbs-1.1.4
	>=virtual/linux-sources-2.6
	"
RDEPEND="
		!sys-infiniband/openib-userspace"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README AUTHORS
}
