# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cman-kernel/cman-kernel-2.6.9-r1.ebuild,v 1.1 2005/03/19 15:41:01 xmerlin Exp $

inherit linux-mod

MY_PV="${PV}-29"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="CMAN cluster kernel module"
HOMEPAGE="http://sources.redhat.com/cluster/"
#SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${MY_P}.tar.gz"

SRC_URI="mirror://gentoo/${MY_P}.tar.gz
        http://dev.gentoo.org/~xmerlin/gfs/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="virtual/linux-sources"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if kernel_is 2 4; then
		die "${P} supports only 2.6 kernels"
	else 
		if ! kernel_is 2 6 9; then
			die "${P} needs a 2.6.9 kernel"
		fi
	fi
}

src_compile() {
	check_KV
	set_arch_to_kernel

	./configure --kernel_src=${KERNEL_DIR} --verbose || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo ""
	einfo "Please remember to re-emerge ${PN} when you upgrade your kernel!"
	einfo ""
}
