# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/magma-plugins/magma-plugins-1.0_pre5.ebuild,v 1.1 2005/01/27 18:27:07 xmerlin Exp $

inherit eutils linux-mod

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Magma cluster interface plugins"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-cluster/gulm-1.0_pre2
	>=sys-cluster/dlm-1.0_pre6"

S="${WORKDIR}/${MY_P}"

src_compile() {
	check_KV
	set_arch_to_kernel

	./configure --kernel_src=${KERNEL_DIR} || die
	#epatch ${FILESDIR}/cman.patch || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
