# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.6.10-r2.ebuild,v 1.3 2005/01/08 17:30:04 plasmaroo Exp $

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
	${FILESDIR}/${P}-disable-iopriowr.patch
	${FILESDIR}/${P}-77094.patch
	${FILESDIR}/${P}-brk-locked.patch"
IUSE=""

DESCRIPTION="Full sources for the Stock Linux kernel and Con Kolivas's high performance patchset"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="${KERNEL_URI} http://ck.kolivas.org/patches/2.6/${KV_FULL/-ck*/}/${KV_FULL}/${CK_PATCH}"

KEYWORDS="~x86 ~amd64"
