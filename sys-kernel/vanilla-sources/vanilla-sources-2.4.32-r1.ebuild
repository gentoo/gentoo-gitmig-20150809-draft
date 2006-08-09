# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-sources/vanilla-sources-2.4.32-r1.ebuild,v 1.1 2006/08/09 18:09:39 phreak Exp $

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"
inherit kernel-2
detect_version

HOMEPAGE="http://www.kernel.org"
SRC_URI="${KERNEL_URI}"
KEYWORDS="~alpha ~ppc ~sparc ~x86"
UNIPATCH_LIST="${FILESDIR}/vanilla-sources-2.4.32-alpha-pci_iommu.patch"
