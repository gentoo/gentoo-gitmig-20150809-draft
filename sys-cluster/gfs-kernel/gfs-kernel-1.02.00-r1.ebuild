# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gfs-kernel/gfs-kernel-1.02.00-r1.ebuild,v 1.3 2006/08/24 18:50:34 xmerlin Exp $

inherit eutils linux-mod

CVS_RELEASE="20060714"
MY_P="cluster-${PV}"

DESCRIPTION="GFS kernel module"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz
	mirror://gentoo/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs-part1.patch.gz
	mirror://gentoo/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs-part2.patch.gz
	http://dev.gentoo.org/~xmerlin/gfs/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs-part1.patch.gz
	http://dev.gentoo.org/~xmerlin/gfs/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs-part2.patch.gz
	"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

IUSE=""

DEPEND="|| (
		>=sys-kernel/vanilla-sources-2.6.12
		>=sys-kernel/gentoo-sources-2.6.12
	)
	>=sys-cluster/dlm-headers-1.02.00-r1
	>=sys-cluster/cman-headers-1.02.00-r1"

RDEPEND=""

S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${WORKDIR}/gfs-kernel-1.02.00-20060714-cvs-part1.patch || die
	if kernel_is 2 6; then
		if [ "$KV_PATCH" -gt "16" ] ; then
			epatch ${WORKDIR}/gfs-kernel-1.02.00-20060714-cvs-part2.patch || die
		fi
	fi
	epatch ${FILESDIR}/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs-compile.patch || die
}

pkg_setup() {
	if kernel_is 2 4; then
		die "${P} supports only 2.6 kernels"
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
	rm -f ${D}/usr/include/linux/* || die
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo ""
	einfo "Please remember to re-emerge ${PN} when you upgrade your kernel!"
	einfo ""
}
