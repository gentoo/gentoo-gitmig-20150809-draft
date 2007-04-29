# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.6.21.ebuild,v 1.1 2007/04/29 02:13:36 marineam Exp $

K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="1"
UNIPATCH_STRICTORDER="1"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for the Linux kernel with Con Kolivas' high performance patchset and Gentoo's basic patchset."
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
IUSE=""
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

CK_PATCH="patch-2.6.21-ck.bz2"

UNIPATCH_LIST="${DISTDIR}/${CK_PATCH}"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} mirror://gentoo/${CK_PATCH}"

pkg_postinst() {
	kernel-2_pkg_postinst

	einfo "This kernel is based on 2.6.21-rc7-ck3."
	einfo "There has not yet ben a ck server release yet."
}
