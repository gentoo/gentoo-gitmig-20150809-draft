# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libnes/libnes-1.1.1.ebuild,v 1.1 2011/06/30 21:53:58 alexxy Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="NetEffect RNIC Userspace Library"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-infiniband/libibverbs-1.1.4"
RDEPEND="${DEPEND}
		!sys-infiniband/openib-userspace"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README AUTHORS ChangeLog
}
