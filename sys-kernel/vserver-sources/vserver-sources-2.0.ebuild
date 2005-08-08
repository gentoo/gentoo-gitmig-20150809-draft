# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-sources/vserver-sources-2.0.ebuild,v 1.1 2005/08/08 19:09:42 hollow Exp $

ETYPE="sources"
CKV="2.6.12"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="11"

K_USEPV=1
K_NOSETEXTRAVERSION=1

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Full sources including gentoo and Linux-VServer patchsets for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="http://dev.gentoo.org/~hollow/vserver"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${HOMEPAGE}/patches/${PF}.tar.bz2"

UNIPATCH_STRICTORDER=1
UNIPATCH_LIST="${DISTDIR}/${PF}.tar.bz2"
