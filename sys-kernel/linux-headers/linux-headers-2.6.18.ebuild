# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.6.18.ebuild,v 1.4 2006/10/31 07:22:58 vapier Exp $

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm cris hppa m68k ia64 ppc ppc64 s390 sh sparc x86"
inherit kernel-2
detect_version

PATCH_VER="1"

SRC_URI="${KERNEL_URI}
	mirror://gentoo/gentoo-headers-${PV}-${PATCH_VER}.tar.bz2"

KEYWORDS="-*"

DEPEND="dev-util/unifdef"
RDEPEND=""

UNIPATCH_LIST="${DISTDIR}/gentoo-headers-${PV}-${PATCH_VER}.tar.bz2"
