# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libibverbs/libibverbs-1.1.4.ebuild,v 1.2 2011/07/02 20:30:15 alexxy Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="1.22.g7257cd3"
OFED_SNAPSHOT="1"

inherit eutils openib

DESCRIPTION="A library allowing programs to use InfiniBand 'verbs' for direct access to IB hardware"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-fs/sysfsutils"
RDEPEND="${DEPEND}
	!sys-infiniband/openib-userspace"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS ChangeLog || die
}
