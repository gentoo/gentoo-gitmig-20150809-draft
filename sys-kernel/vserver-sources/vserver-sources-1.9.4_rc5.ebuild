# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-sources/vserver-sources-1.9.4_rc5.ebuild,v 1.1 2005/02/07 14:04:14 hollow Exp $

ETYPE="sources"
CKV="2.6.11_rc3"

K_NOSETEXTRAVERSION=1

inherit kernel-2
detect_version


DESCRIPTION="vserver patched sources for the ${KV_MAJOR}.${KV_MINOR} kernel branch"
HOMEPAGE="http://www.linux-vserver.org"
SRC_URI="${KERNEL_URI} http://vserver.13thfloor.at/Experimental/RC-${PV/_rc*}/patch-${CKV/_rc/-rc}-vs${PV/_rc/-rc}.diff"

KEYWORDS="~x86"

UNIPATCH_LIST="${DISTDIR}/patch-${CKV/_rc/-rc}-vs${PV/_rc/-rc}.diff"
UNIPATCH_STRICTORDER=1
