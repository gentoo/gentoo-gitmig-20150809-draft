# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/development-sources/development-sources-2.6.9.ebuild,v 1.8 2004/11/27 13:16:08 swegener Exp $

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"
inherit kernel-2
detect_arch
detect_version

DESCRIPTION="Full sources for the vanilla 2.6 kernel tree"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
	http://mirror/gentoo/linux-2.6.9-buildfix.patch"
UNIPATCH_LIST="${ARCH_PATCH} ${DISTDIR}/linux-2.6.9-buildfix.patch"

KEYWORDS="x86 ~ia64 ppc amd64 ~alpha"
IUSE=""
