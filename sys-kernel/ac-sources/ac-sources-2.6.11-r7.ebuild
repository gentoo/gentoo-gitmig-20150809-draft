# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ac-sources/ac-sources-2.6.11-r7.ebuild,v 1.1 2005/06/21 17:06:34 marineam Exp $

K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"
ETYPE="sources"
inherit kernel-2
detect_version
K_NOSETEXTRAVERSION="don't_set_it"

UPDATE_TO="2.6.11.12"
UPDATE_PATCH="patch-${KV}-${UPDATE_TO}.gz"

UNIPATCH_LIST="
	${DISTDIR}/patch-${KV}.bz2
	${DISTDIR}/${UPDATE_PATCH}"

DESCRIPTION="Alan Cox's kernel, mostly stuff destined for the mainline or RedHat's vendor kernel"
SRC_URI="${KERNEL_URI} mirror://gentoo/${UPDATE_PATCH}
	mirror://kernel/linux/kernel/people/alan/linux-2.6/${KV/-ac*/}/patch-${KV}.bz2"

KEYWORDS="~x86 ~amd64 ~ia64 ~ppc -*"
IUSE=""

