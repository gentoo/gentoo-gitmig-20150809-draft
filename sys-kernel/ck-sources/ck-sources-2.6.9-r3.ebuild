# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.6.9-r3.ebuild,v 1.5 2004/11/27 17:49:41 plasmaroo Exp $

UNIPATCH_LIST="${DISTDIR}/patch-${KV}.bz2
	${FILESDIR}/${P}.binfmt_elf.patch
	${FILESDIR}/${P}.binfmt_a.out.patch
	${FILESDIR}/${PN}.AF_UNIX.patch"
K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

K_NOSETEXTRAVERSION="yes"
K_NOUSENAME="yes"
ETYPE="sources"
inherit kernel-2
detect_version
IUSE=""

DESCRIPTION="Full sources for the Stock Linux kernel and Con Kolivas's high performance patchset"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"
SRC_URI="${KERNEL_URI} http://ck.kolivas.org/patches/2.6/${KV/-ck*/}/${KV}/patch-${KV}.bz2"

KEYWORDS="~x86 ~amd64"
