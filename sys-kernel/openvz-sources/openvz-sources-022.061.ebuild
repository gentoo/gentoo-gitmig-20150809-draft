# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openvz-sources/openvz-sources-022.061.ebuild,v 1.1 2006/01/12 10:00:41 hollow Exp $

ETYPE="sources"
CKV="2.6.8"

K_USEPV=1
K_NOSETEXTRAVERSION=1

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~amd64 ~x86"
IUSE=""

DESCRIPTION="Full sources including OpenVZ patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="http://www.openvz.org"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
	http://dev.gentoo.org/~hollow/distfiles/${PF}.tar.bz2
	http://dev.gentoo.org/~phreak/distfiles/${PF}.tar.bz2"

UNIPATCH_STRICTORDER=1
UNIPATCH_LIST="${DISTDIR}/${PF}.tar.bz2"
