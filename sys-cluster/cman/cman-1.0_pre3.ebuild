# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cman/cman-1.0_pre3.ebuild,v 1.3 2005/01/27 17:49:38 xmerlin Exp $

inherit eutils linux-mod

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="general-purpose symmetric cluster manager"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-cluster/ccs-0.7
	>=sys-cluster/cman-kernel-2.6.9"

RDEPEND="virtual/libc"


S="${WORKDIR}/${MY_P}"

src_compile() {
	check_KV
	set_arch_to_kernel

	./configure --kernel_src=${KERNEL_DIR} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
