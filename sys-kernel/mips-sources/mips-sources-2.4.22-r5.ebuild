# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.22-r5.ebuild,v 1.2 2003/12/17 07:03:48 kumba Exp $

ETYPE="sources"
inherit kernel

OKV=${PV/_/-}
CVSDATE=20031015
S=${WORKDIR}/linux-${OKV}-${CVSDATE}
EXTRAVERSION=-mipscvs-${CVSDATE}
KV="${OKV}${EXTRAVERSION}"

inherit eutils

# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 25 Sep 2003
# 3) patch to fix arch/mips[64]/Makefile to pass appropriate CFLAGS
# 4) patch to tweak arch/mips64/Makefile to pass -Wa,-mabi=o64 instead of -Wa,-32


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2"
HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-* mips"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Patch arch/mips/Makefile for gcc
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-fix.patch

	# Patch arch/mips64/Makefile to pass -Wa,mabi=o64
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-mips64-tweak.patch

	epatch ${FILESDIR}/do_brk_fix.patch || die "failed to patch for do_brk vuln"

	kernel_universal_unpack
}

pkg_postinst() {

	# Do kernel postinst stuff
	kernel_pkg_postinst

	# Create /usr/src/linux symlink
	ln -sf linux-${OKV}-${CVSDATE} ${ROOT}/usr/src/linux
}
