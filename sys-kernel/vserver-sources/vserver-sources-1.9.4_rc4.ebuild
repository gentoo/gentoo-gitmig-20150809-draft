# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-sources/vserver-sources-1.9.4_rc4.ebuild,v 1.1 2005/02/03 13:05:07 hollow Exp $

ETYPE="sources"
OKV="2.6.10"
K_NOSETEXTRAVERSION=1

inherit kernel-2
detect_version

DESCRIPTION="vserver patched sources for the ${KV_MAJOR}.${KV_MINOR} kernel branch"
HOMEPAGE="http://www.linux-vserver.org"
SRC_URI="${KERNEL_URI} http://vserver.13thfloor.at/Experimental/RC-${PV/_rc*}/patch-${OKV}-vs${PV/_rc/-rc}.diff"

KEYWORDS="~x86"

UNIPATCH_LIST="${DISTDIR}/patch-${OKV}-vs${PV/_rc/-rc}.diff"
