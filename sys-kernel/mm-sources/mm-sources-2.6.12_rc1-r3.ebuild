# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mm-sources/mm-sources-2.6.12_rc1-r3.ebuild,v 1.1 2005/03/27 22:50:35 chainsaw Exp $

K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"

ETYPE="sources"
inherit kernel-2
detect_version
UNIPATCH_LIST="${DISTDIR}/${KV_FULL}.bz2"
K_NOSETEXTRAVERSION="don't_set_it"
RESTRICT="nomirror"
DESCRIPTION="Andrew Morton's kernel, mostly fixes for 2.6 vanilla, some vm stuff too"
SRC_URI="${KERNEL_URI} mirror://kernel/linux/kernel/people/akpm/patches/2.6/${KV/-mm*/}/${KV}/${KV}.bz2"

KEYWORDS="~x86 ~amd64 ~ia64 -* ~ppc"
IUSE=""

K_EXTRAEINFO="This kernel is not supported by Gentoo due to its unstable and
experimental nature. If you have any issues, try a matching development-sources
ebuild -- if the problem persists there, please file a bug at http://bugme.osdl.org.
If the problem only occurs with mm-sources then please contact Andrew Morton to
get your issue resolved."
