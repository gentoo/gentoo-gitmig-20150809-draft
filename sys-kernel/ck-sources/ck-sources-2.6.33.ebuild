# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.6.33.ebuild,v 1.1 2010/04/18 00:01:10 nelchael Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="2"
CK_VERSION="1"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Con Kolivas' high performance patchset + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~dsd/genpatches/
	http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/"
IUSE=""

CK_URI="mirror://kernel/linux/kernel/people/ck/patches/2.6/${PV}/${PV}-ck${CK_VERSION}/patch-${PV}-ck${CK_VERSION}.bz2"

UNIPATCH_LIST="${DISTDIR}/patch-${PV}-ck${CK_VERSION}.bz2"
UNIPATCH_STRICTORDER="yes"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${CK_URI}"

KEYWORDS="~amd64 ~x86"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
