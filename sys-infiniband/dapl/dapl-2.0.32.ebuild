# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/dapl/dapl-2.0.32.ebuild,v 1.2 2011/07/02 20:30:15 alexxy Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB - Direct Access Provider Library"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND=">=sys-infiniband/libibverbs-1.1.4
		>=sys-infiniband/librdmacm-1.0.14.1"
RDEPEND="${DEPEND}
		!sys-infiniband/openib-userspace"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README AUTHORS
}
