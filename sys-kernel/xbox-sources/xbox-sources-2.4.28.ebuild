# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xbox-sources/xbox-sources-2.4.28.ebuild,v 1.1 2004/11/24 14:13:57 chrb Exp $

ETYPE="sources"
inherit kernel-2
detect_version

XBOX_PATCH="xbox-sources-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-r0.patch.bz2"

SRC_URI="${KERNEL_URI}
	mirror://gentoo/${XBOX_PATCH}
	mirror://gentoo/${P}.squashfs.patch.bz2"
DESCRIPTION="Full sources for the Xbox Linux kernel"
HOMEPAGE="http://www.xbox-linux.org"
K_NOSETEXTRAVERSION="don't_set_it"
KEYWORDS="x86 -*"

UNIPATCH_LIST="
	${DISTDIR}/${XBOX_PATCH}
	${DISTDIR}/${P}.squashfs.patch.bz2"
