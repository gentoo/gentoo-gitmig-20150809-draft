# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mm-sources/mm-sources-2.6.2_rc1-r3.ebuild,v 1.1 2004/01/25 03:55:30 iggy Exp $

UNIPATCH_LIST="${DISTDIR}/${KV}.bz2"
K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

ETYPE="sources"
inherit kernel-2
detect_version

RESTRICT="nomirror"

DESCRIPTION="Andrew Morton's kernel, mostly fixes for 2.6 vanilla, some vm stuff too"
SRC_URI="${KERNEL_URI} mirror://kernel/linux/kernel/people/akpm/patches/2.6/${KV/-mm*/}/${KV}/${KV}.bz2"

KEYWORDS="x86 ~amd64 ~ia64 -*"

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to x86-kernel@gentoo.org.
Please read the ChangeLog and associated docs for more information."

K_EXTRAEWARN="NOTE: processor selection has changed. You'll need to make sure you
select the proper cpu type during make oldconfig"
