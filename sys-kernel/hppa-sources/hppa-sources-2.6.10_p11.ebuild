# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-sources/hppa-sources-2.6.10_p11.ebuild,v 1.1 2005/01/16 13:30:01 gmsoft Exp $

ETYPE="sources"
inherit kernel-2
K_NOUSENAME=true
K_NOSETEXTRAVERSION=true

detect_version

DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
PATCH_LEVEL="${PV/${OKV}_p/}"
SRC_URI="${KERNEL_URI} http://ftp.parisc-linux.org/cvs/linux-2.6/patch-${OKV}-pa${PATCH_LEVEL}.gz"
UNIPATCH_LIST="${DISTDIR}/patch-${OKV}-pa${PATCH_LEVEL}.gz ${FILESDIR}/CAN-2004-1056.patch ${FILESDIR}/LSM-capability-fix.patch"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://parisc-linux.org"
KEYWORDS="hppa -*"
