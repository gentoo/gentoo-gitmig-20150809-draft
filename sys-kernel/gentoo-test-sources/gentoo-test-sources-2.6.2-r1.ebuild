# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-test-sources/gentoo-test-sources-2.6.2-r1.ebuild,v 1.1 2004/02/07 21:15:45 iggy Exp $

UNIPATCH_LIST="${DISTDIR}/patch-2.6.2-ck1.bz2"
ETYPE="sources"

inherit kernel-2
detect_version

RESTRICT="nomirror"
EXTRAVERSION="gentest-r1"
KV="2.6.2-gentest-r1"
S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the Gentoo Kernel."
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	http://ck.kolivas.org/patches/2.6/2.6.2/2.6.2-ck1/patch-2.6.2-ck1.bz2"
KEYWORDS="~x86 ~amd64 ~ia64 -*"
SLOT="${KV}"

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to x86-kernel@gentoo.org.
Please read the ChangeLog and associated docs for more information."

