# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/infinipath-psm/infinipath-psm-1.14.ebuild,v 1.2 2012/01/20 13:19:38 alexxy Exp $

EAPI="4"

OFED_VER="1.5.3.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB userspace driver for the PathScale InfiniBand HCAs"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND=">=sys-infiniband/libibverbs-1.1.4"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e 's:uname -p:uname -m:g' \
		-e 's:-Werror::g' \
		-i buildflags.mak || die
	epatch "${FILESDIR}/${PN}-include.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README
	# install udev rules
	dodir /etc/udev/rules.d
	insinto /etc/udev/rules.d
	doins "${FILESDIR}/42-infinipath-psm.rules" || die
}
