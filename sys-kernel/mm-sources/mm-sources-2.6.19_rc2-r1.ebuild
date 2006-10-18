# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mm-sources/mm-sources-2.6.19_rc2-r1.ebuild,v 1.1 2006/10/18 08:47:57 voxus Exp $

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

KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

K_EXTRAEINFO="This kernel is not supported by Gentoo due to its unstable and
experimental nature. If you have any issues, try a matching vanilla-sources
ebuild -- if the problem persists there, please file a bug at http://bugme.osdl.org.
If the problem only occurs with mm-sources then please contact Andrew Morton to
get your issue resolved."
