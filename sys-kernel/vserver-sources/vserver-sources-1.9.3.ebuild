# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-sources/vserver-sources-1.9.3.ebuild,v 1.2 2005/02/12 13:14:55 hollow Exp $

ETYPE="sources"
CKV="2.6.9"

K_USEPV=1
K_NOSETEXTRAVERSION=1

inherit kernel-2
detect_version

DESCRIPTION="vserver patched sources for the ${KV_MAJOR}.${KV_MINOR} kernel branch"
HOMEPAGE="http://www.linux-vserver.org"
SRC_URI="${KERNEL_URI} http://www.13thfloor.at/vserver/d_rel${KV_MAJOR}${KV_MINOR}/v${PV}/patch-${CKV//_/-}-vs${PV}.diff"

KEYWORDS="x86"

UNIPATCH_LIST="${DISTDIR}/patch-${CKV//_/-}-vs${PV}.diff"
UNIPATCH_STRICTORDER=1
