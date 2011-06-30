# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libipathverbs/libipathverbs-1.2.ebuild,v 1.1 2011/06/30 21:37:01 alexxy Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB userspace driver for the PathScale InfiniBand HCAs"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-infiniband/libibverbs-1.1.4"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README AUTHOR
}
