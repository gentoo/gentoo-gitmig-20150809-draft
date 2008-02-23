# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xen-sources/xen-sources-2.6.22.ebuild,v 1.1 2008/02/23 23:40:04 marineam Exp $

ETYPE="sources"
UNIPATCH_STRICTORDER="1"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="11"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for a dom0/domU Linux kernel to run under Xen"
HOMEPAGE="http://xen.xensource.com/"

KEYWORDS="~x86 ~amd64"

XENPATCHES_VER="2"
XENPATCHES="xen-patches-${PV}-${XENPATCHES_VER}.tar.bz2"
XENPATCHES_URI="mirror://gentoo/${XENPATCHES}"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${XENPATCHES_URI}"

UNIPATCH_LIST="${DISTDIR}/${XENPATCHES}"
# patches in genpatches that are in later upstream 2.6.22.y releases
UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE}
	2400_atl1-disable-broken-64-bit-DMA
	2710_alsa-hdsp-dds-offset"

DEPEND="${DEPEND} >=sys-devel/binutils-2.17"
