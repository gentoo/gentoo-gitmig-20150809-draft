# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openvz-sources/openvz-sources-022.045-r1.ebuild,v 1.3 2005/11/26 08:57:48 phreak Exp $

ETYPE="sources"
CKV="2.6.8"

K_USEPV=1
K_NOSETEXTRAVERSION=1

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~x86"

DESCRIPTION="Full sources including OpenVZ patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="http://www.openvz.org"
SRC_URI="${KERNEL_URI} ${ARCH_URI} http://dev.gentoo.org/~hollow/distfiles/${PF}.tar.bz2 http://dev.gentoo.org/~phreak/distfiles/${PF}.tar.bz2"

UNIPATCH_STRICTORDER=1
UNIPATCH_LIST="${DISTDIR}/${PF}"
