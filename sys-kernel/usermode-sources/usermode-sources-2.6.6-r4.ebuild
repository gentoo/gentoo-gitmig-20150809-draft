# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/usermode-sources/usermode-sources-2.6.6-r4.ebuild,v 1.1 2004/07/21 11:20:04 plasmaroo Exp $

K_NOUSENAME="yes"
ETYPE="sources"

inherit kernel-2
UML_PATCH="uml-patch-2.6.6-1"
OKV="${PV}"
EXTRAVERSION="-${UML_PATCH//-*-/}-${PR}"
KV="${OKV}${EXTRAVERSION}"
S="${WORKDIR}/linux-${KV}"
IUSE=""

UNIPATCH_LIST="${DISTDIR}/${UML_PATCH}.bz2 ${FILESDIR}/${PN}.CAN-2004-0497.patch ${FILESDIR}/${P}.FPULockup-53804.patch ${FILESDIR}/${PN}-2.6.IPTables-RDoS.patch ${FILESDIR}/${P}.ProcPerms.patch ${FILESDIR}/${PN}-2.6.CAN-2004-0596.patch"

DESCRIPTION="Full (vanilla) sources for the User Mode Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${PV}.tar.bz2
	mirror://sourceforge/user-mode-linux/${UML_PATCH}.bz2"
HOMEPAGE="http://www.kernel.org/ http://user-mode-linux.sourceforge.net"
SLOT="${KV}"
KEYWORDS="~x86 ~ppc"
RESTRICT="nomirror"
