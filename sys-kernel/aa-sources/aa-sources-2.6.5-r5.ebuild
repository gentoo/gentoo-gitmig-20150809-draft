# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/aa-sources/aa-sources-2.6.5-r5.ebuild,v 1.1 2004/04/17 01:04:17 steel300 Exp $

UNIPATCH_LIST="${DISTDIR}/${KV}.bz2"
K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

K_NOUSENAME="yes"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for Andrea Arcangeli's Linux kernel"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/"
SRC_URI="${KERNEL_URI} mirror://kernel/linux/kernel/people/andrea/kernels/v2.6/${KV}.bz2"

KEYWORDS="~x86 ~amd64 ~sparc"

