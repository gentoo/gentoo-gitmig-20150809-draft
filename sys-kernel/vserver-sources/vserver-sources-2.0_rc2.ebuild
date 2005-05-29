# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-sources/vserver-sources-2.0_rc2.ebuild,v 1.1 2005/05/29 09:15:44 hollow Exp $

ETYPE="sources"
CKV="2.6.11.10"

K_USEPV=1
K_NOSETEXTRAVERSION=1

inherit kernel-2
detect_version

DESCRIPTION="vserver patched sources for the ${KV_MAJOR}.${KV_MINOR} kernel branch"
HOMEPAGE="http://www.linux-vserver.org"
SRC_URI="${KERNEL_URI} 	mirror://gentoo/${P}.patch.bz2"

KEYWORDS="~amd64 ~x86"
IUSE=""

UNIPATCH_LIST="${DISTDIR}/${P}.patch.bz2"
