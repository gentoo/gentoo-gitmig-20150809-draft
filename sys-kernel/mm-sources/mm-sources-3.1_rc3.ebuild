# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mm-sources/mm-sources-3.1_rc3.ebuild,v 1.1 2011/08/25 09:26:11 psomas Exp $

EAPI=4

K_SECURITY_UNSUPPORTED="yes"
K_DEBLOB_AVAILABLE=0

ETYPE="sources"

inherit kernel-2 eutils
detect_version

K_NOSETEXTRAVERSION="don't_set_it"

DESCRIPTION="Andrew Morton's -mmotm quilt patchset"
HOMEPAGE="http://userweb.kernel.org/~akpm/mmotm/"

PATCHSET_URI="http://userweb.kernel.org/~akpm/mmotm/broken-out.tar.gz ->
broken-out-${PV}.tar.gz"
SRC_URI="${KERNEL_URI} ${PATCHSET_URI}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/quilt"
RDEPEND="${DEPEND}"

pkg_setup() {
	ewarn
	ewarn "${PN} are *not* supported by the Gentoo Kernel Project in any way."
	ewarn "Do *not* open bugs at Gentoo bugzilla, unless you have issues with"
	ewarn "the ebuilds."
	ewarn
	kernel-2_pkg_setup
}

src_unpack() {
	kernel-2_src_unpack
	unpack broken-out-${PV}.tar.gz
}

src_prepare() {
	einfo "Moving -mmotm quilt patchset to patches/"
	mv broken-out patches || die "Unable to move -mmotm patchset to patches/"

	einfo "Pushing -mmotm quilt patchset."
	quilt push -aq  --leave-rejects || die "Unable to apply -mmotm quilt patchset. See the *.rej files in ${S} for more infomation."
}
