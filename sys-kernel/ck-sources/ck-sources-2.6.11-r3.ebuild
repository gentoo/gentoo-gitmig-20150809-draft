# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.6.11-r3.ebuild,v 1.1 2005/03/27 23:04:16 chainsaw Exp $

K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

K_NOSETEXTRAVERSION="yes"
K_NOUSENAME="yes"
ETYPE="sources"
inherit kernel-2
detect_version

CK_PATCH="patch-${KV_FULL}.bz2"
UNIPATCH_LIST="
	${DISTDIR}/${CK_PATCH}
	${FILESDIR}/${P}-74070.patch
	${FILESDIR}/${P}-lowmem-reserve-oops.patch"
IUSE=""

DESCRIPTION="Full sources for the Stock Linux kernel and Con Kolivas's high performance patchset"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="${KERNEL_URI} http://ck.kolivas.org/patches/2.6/${KV_FULL/-ck*/}/${KV_FULL}/${CK_PATCH}"

KEYWORDS="~x86 ~amd64"
