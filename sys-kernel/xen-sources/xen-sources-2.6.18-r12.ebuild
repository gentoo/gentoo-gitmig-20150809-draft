# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xen-sources/xen-sources-2.6.18-r12.ebuild,v 1.3 2010/06/24 01:37:43 angelos Exp $

ETYPE="sources"
UNIPATCH_STRICTORDER="1"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="10"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for a dom0/domU Linux kernel to run under Xen"
HOMEPAGE="http://xen.org/"
IUSE=""

KEYWORDS="amd64 x86"

XENPATCHES_VER="12"
XENPATCHES="xen-patches-${PV}-${XENPATCHES_VER}.tar.bz2"
XENPATCHES_URI="mirror://gentoo/${XENPATCHES}"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${XENPATCHES_URI}"

UNIPATCH_LIST="${DISTDIR}/${XENPATCHES}"
