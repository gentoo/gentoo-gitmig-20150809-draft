# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xen-sources/xen-sources-2.6.16.28-r2.ebuild,v 1.1 2007/01/27 07:44:34 aross Exp $

ETYPE="sources"
inherit kernel-2 eutils
detect_arch
detect_version

XEN_VERSION="3.0.2"
XEN_URI="mirror://gentoo/${P}-${XEN_VERSION}.patch.bz2"

DESCRIPTION="Linux kernel ${OKV} with Xen ${XEN_VERSION}"
HOMEPAGE="http://kernel.org http://www.xensource.com/xen/xen/"
SRC_URI="${KERNEL_URI} ${ARCH_URI} ${XEN_URI}"

KEYWORDS="~x86 ~amd64"

UNIPATCH_LIST="${DISTDIR}/${XEN_URI##*/}
	${FILESDIR}/${P}-CVE-2006-3468.patch
	${FILESDIR}/${P}-CVE-2006-6333.patch
	${FILESDIR}/CVE-2005-4352.patch
	${FILESDIR}/CVE-2006-4572.patch
	${FILESDIR}/CVE-2006-5619.patch
	${FILESDIR}/CVE-2006-6056.patch
	${FILESDIR}/CVE-2006-6060.patch
	${FILESDIR}/dvb-core-ule-sndu.patch"
