# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ac-sources/ac-sources-2.6.9-r2.ebuild,v 1.1 2004/10/21 19:26:59 lostlogic Exp $

UNIPATCH_LIST="${DISTDIR}/patch-${KV}.bz2"
K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

ETYPE="sources"
inherit kernel-2
detect_version
K_NOSETEXTRAVERSION="don't_set_it"
RESTRICT="nomirror"
DESCRIPTION="Alan Cox's kernel, mostly stuff destined for mailine or RedHat's vendor kernel"
SRC_URI="${KERNEL_URI} mirror://kernel/linux/kernel/people/alan/linux-2.6/${KV/-ac*/}/patch-${KV}.bz2"

KEYWORDS="~x86 ~amd64 ~ia64 -* ~ppc"
IUSE=""

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to x86-kernel@gentoo.org.
Please read the ChangeLog and associated docs for more information."
