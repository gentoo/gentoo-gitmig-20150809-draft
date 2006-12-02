# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.6.19.ebuild,v 1.2 2006/12/02 23:16:24 vapier Exp $

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm cris hppa m68k mips ia64 ppc ppc64 s390 sh sparc x86"
inherit kernel-2
detect_version

PATCH_VER="1"

SRC_URI="${KERNEL_URI}"

KEYWORDS="-*"

DEPEND="dev-util/unifdef"
RDEPEND=""

UNIPATCH_LIST=""

if [[ -n ${PATCH_VER} ]] ; then
	SRC_URI="${SRC_URI} mirror://gentoo/gentoo-headers-${PV}-${PATCH_VER}.tar.bz2"
	UNIPATCH_LIST="${DISTDIR}/gentoo-headers-${PV}-${PATCH_VER}.tar.bz2 ${UNIPATCH_LIST}"
fi
