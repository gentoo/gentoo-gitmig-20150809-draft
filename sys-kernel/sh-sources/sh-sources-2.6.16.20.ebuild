# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/sh-sources/sh-sources-2.6.16.20.ebuild,v 1.2 2007/01/02 01:48:39 dsd Exp $

ETYPE="sources"
K_SECURITY_UNSUPPORTED="1"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
inherit kernel-2
detect_version

STAMP=20060611
ARCH_URI="mirror://gentoo/linux-${PV}-sh-${STAMP}.patch.bz2"
UNIPATCH_LIST="${DISTDIR}/linux-${PV}-sh-${STAMP}.patch.bz2"
UNIPATCH_STRICTORDER="yes"

DESCRIPTION="Full SuperH sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="http://dev.gentoo.org/~dsd/genpatches"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"

KEYWORDS="-* sh"
IUSE=""

pkg_postinst() {
	postinst_sources

	echo
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
