# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

ETYPE="sources"
inherit kernel-2
detect_version

XBOX_PATCH="xbox-sources-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-${PR}.patch.bz2"

SRC_URI="${KERNEL_URI}
	mirror://gentoo/${XBOX_PATCH}"
DESCRIPTION="Full sources for the Xbox Linux kernel"
HOMEPAGE="http://www.xbox-linux.org"
K_NOSETEXTRAVERSION="don't_set_it"
KEYWORDS="~x86 -*"

UNIPATCH_LIST="${DISTDIR}/${XBOX_PATCH}"
