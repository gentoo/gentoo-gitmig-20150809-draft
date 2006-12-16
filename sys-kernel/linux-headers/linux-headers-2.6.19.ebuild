# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.6.19.ebuild,v 1.3 2006/12/16 11:43:40 vapier Exp $

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm cris hppa m68k mips ia64 ppc ppc64 s390 sh sparc x86"
inherit kernel-2
detect_version

PATCH_VER="2"
SRC_URI="mirror://gentoo/gentoo-headers-base-2.6.19.tar.bz2"
[[ -n ${PATCH_VER} ]] && SRC_URI="${SRC_URI} mirror://gentoo/gentoo-headers-${OKV}-${PATCH_VER}.tar.bz2"
UNIPATCH_LIST="${DISTDIR}/patch-${KV}.bz2"

KEYWORDS="-*"

DEPEND="dev-util/unifdef"
RDEPEND=""

S=${WORKDIR}/gentoo-headers-base-${OKV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	[[ -n ${PATCH_VER} ]] && EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/${OKV}
}
