# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.6.11_p7-r1.ebuild,v 1.1 2005/05/11 07:52:10 marineam Exp $

K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

#K_NOSETEXTRAVERSION="no"
K_NOUSENAME="yes"
ETYPE="sources"
inherit kernel-2
detect_version

# A few hacks to set ck version via _p instead of -r
MY_P=${P/_p*/}
MY_PR=${PR/r/-r}
EXTRAVERSION=-ck${PV/*_p/}${MY_PR}
KV_FULL=${OKV}${EXTRAVERSION}
KV_CK=${KV_FULL/-r*/}

CK_PATCH="patch-${KV_CK}.bz2"
UNIPATCH_LIST="
	${DISTDIR}/${CK_PATCH}
	${FILESDIR}/${MY_P}-74070.patch
	${FILESDIR}/${MY_P}-lowmem-reserve-oops.patch
	${FILESDIR}/${MY_P}-87913.patch
	${FILESDIR}/${MY_P}-85795.patch"
IUSE=""

DESCRIPTION="Full sources for the Stock Linux kernel and Con Kolivas's high performance patchset"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="${KERNEL_URI} http://ck.kolivas.org/patches/2.6/${OKV}/${KV_CK}/${CK_PATCH}"

KEYWORDS="~x86 ~amd64"
