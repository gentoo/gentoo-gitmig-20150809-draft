# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-sources/vserver-sources-1.9.5_rc1-r1.ebuild,v 1.2 2005/03/10 07:03:30 eradicator Exp $

ETYPE="sources"
CKV="2.6.11"

K_USEPV=1
K_NOSETEXTRAVERSION=1

inherit kernel-2
detect_version

VSPV="${PV/_rc/-rc}"

DESCRIPTION="vserver patched sources for the ${KV_MAJOR}.${KV_MINOR} kernel branch"
HOMEPAGE="http://www.linux-vserver.org"
SRC_URI="${KERNEL_URI} mirror://gentoo/patch-${CKV//_/-}-vs${VSPV}-grsec-2.1.2.diff http://mirror.alldas.org/www.grsecurity.net/grsecurity-2.1.2-2.6.11-200503041925.patch"

KEYWORDS="~amd64 ~x86"

UNIPATCH_LIST="${DISTDIR}/grsecurity-2.1.2-2.6.11-200503041925.patch ${DISTDIR}/patch-${CKV//_/-}-vs${VSPV}-grsec-2.1.2.diff"
UNIPATCH_STRICTORDER=1
