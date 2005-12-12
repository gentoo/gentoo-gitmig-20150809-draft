# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xbox-sources/xbox-sources-2.6.14.3.ebuild,v 1.1 2005/12/12 21:39:40 gimli Exp $

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE='sources'
inherit kernel-2
detect_arch
detect_version

# version of gentoo patchset
XBOX_PATCHES=xbox-sources-2.6.14-20051208.patch.bz2

KEYWORDS="~x86 -*"
UNIPATCH_LIST="
	${ARCH_PATCH}
	${DISTDIR}/${XBOX_PATCHES}"
DESCRIPTION="Full sources for the Xbox Linux kernel"
SRC_URI="${KERNEL_URI}
	${ARCH_URI}
	mirror://gentoo/${XBOX_PATCHES}"
