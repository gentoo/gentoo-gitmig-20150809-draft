# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libibumad/libibumad-1.3.7.ebuild,v 1.2 2011/07/02 20:30:15 alexxy Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB User MAD library functions which sit on top of the user MAD modules in the kernel."
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	>=sys-infiniband/libibverbs-1.1.4
	"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
