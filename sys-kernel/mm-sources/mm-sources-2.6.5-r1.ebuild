# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mm-sources/mm-sources-2.6.5-r1.ebuild,v 1.3 2004/04/07 02:27:13 steel300 Exp $

UNIPATCH_LIST="${DISTDIR}/${KV}.bz2"
K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

ETYPE="sources"
inherit kernel-2
detect_version
K_NOSETEXTRAVERSION="don't_set_it"
DESCRIPTION="Andrew Morton's kernel, mostly fixes for 2.6 vanilla, some vm stuff too"
SRC_URI="${KERNEL_URI} mirror://gentoo.org/${KV}-gentoo1.bz2"
KEYWORDS="x86 ~amd64 ~ia64 -*"

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to x86-kernel@gentoo.org.
Please read the ChangeLog and associated docs for more information."

pkg_postinst() {
	ewarn "If you use the nvidia-kernel binary module, then be sure to verify that"
	ewarn "Kernel Hacking --> Use 4Kb for kernel stacks instead of 8Kb is not"
	ewarn "selected. It causes the lockups and will not work with it enabled."
}
