# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libehca/libehca-1.2.2.ebuild,v 1.3 2012/03/22 17:08:43 alexxy Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="0.1.g69e1a88"
OFED_SNAPSHOT="1"

inherit openib

DESCRIPTION="OpenIB - IBM eServer eHCA Infiniband device driver for Linux on POWER"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND=">=sys-infiniband/libibverbs-1.1.4"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README INSTALL
}
