# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mm-sources/mm-sources-2.6.1-r4.ebuild,v 1.1 2004/01/16 09:50:51 iggy Exp $

ETYPE="sources"
inherit kernel-2
detect_version
KV=${KV/-r/}
UNIPATCH_LIST="${DISTDIR}/${KV}.bz2"
K_NOSETEXTRAVERSION="don't_set_it"
RESTRICT="nomirror"
S=${WORKDIR}/linux-${KV}

DESCRIPTION="Andrew Morton's kernel, mostly fixes for 2.6 vanilla, some vm stuff too"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	mirror://kernel/linux/kernel/people/akpm/patches/2.6/${OKV}/${KV}/${KV}.bz2"
KEYWORDS="x86 ~amd64 ~ia64 -*"
SLOT="${KV}"

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to x86-kernel@gentoo.org.
Please read the ChangeLog and associated docs for more information."
