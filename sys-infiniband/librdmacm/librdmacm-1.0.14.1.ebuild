# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/librdmacm/librdmacm-1.0.14.1.ebuild,v 1.2 2011/07/02 20:30:14 alexxy Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="1"

inherit eutils openib

DESCRIPTION="OpenIB userspace RDMA CM library"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND=">=sys-infiniband/libibverbs-1.1.4"
RDEPEND="${DEPEND}
		!sys-infiniband/openib-userspace"

src_install() {
	emake DESTDIR="${D}" install ||
	dodoc README AUTHORS ChangeLog || die
}
