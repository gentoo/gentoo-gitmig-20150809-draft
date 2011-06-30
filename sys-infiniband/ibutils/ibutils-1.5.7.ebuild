# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/ibutils/ibutils-1.5.7.ebuild,v 1.1 2011/06/30 21:25:54 alexxy Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB userspace tools"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-infiniband/libibverbs-1.1.4
		>=dev-lang/tk-8.4"
RDEPEND="${DEPEND}
		!sys-infiniband/openib-userspace"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README AUTHORS ChangeLog
}
