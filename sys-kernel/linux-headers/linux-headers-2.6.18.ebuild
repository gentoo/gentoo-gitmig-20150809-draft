# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.6.18.ebuild,v 1.2 2006/10/08 21:54:28 vapier Exp $

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm hppa m68k ia64 ppc ppc64 s390 sh sparc x86"
inherit kernel-2
detect_version

SRC_URI="${KERNEL_URI}"
KEYWORDS="-*"

DEPEND="dev-util/unifdef"
RDEPEND=""
