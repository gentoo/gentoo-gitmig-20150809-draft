# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libibcm/libibcm-1.0.5.ebuild,v 1.2 2011/07/02 20:30:15 alexxy Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB Userspace CM library"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

RDEPEND=">=sys-infiniband/libibverbs-1.1.4"
DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README AUTHORS ChangeLog
}
