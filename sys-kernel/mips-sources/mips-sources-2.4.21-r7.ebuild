# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.21-r7.ebuild,v 1.2 2004/02/18 21:48:46 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20030803"
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"
COBALTPATCHVER="1.0"

# Miscellaneous stuff
S=${WORKDIR}/linux-${OKV}-${CVSDATE}

# Eclass stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 03 Aug 2003
# 3) patch to fix arch/mips[64]/Makefile to pass appropriate CFLAGS
# 4) Fix for headers on big-endian machines
# 5) do_brk fix
# 6) mremap fix
# 7) RTC fixes
# 8) do_munmap fix
# 9) Patches for Cobalt support


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/cobalt-patches-24xx-${COBALTPATCHVER}.tar.bz2"
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

	# Patch arch/mips/Makefile for gcc (Pass -mips3/-mips4 for r4k/r5k cpus)
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-fix.patch

	# Big Endian Fix (Fix in headers for big-endian machines)
	epatch ${FILESDIR}/bigendian-byteorder-fix.patch

	# do_brk fix (Fixes exploit that hit several debian servers)
	epatch ${FILESDIR}/do_brk_fix.patch

	# mremap fix (Possibly Exploitable)
	epatch ${FILESDIR}/mremap-fix-try2.patch

	# MIPS RTC Fixes (Fixes memleaks, backport from 2.4.24)
	epatch ${FILESDIR}/rtc-fixes.patch

	# do_munmap fix (Possibly Exploitable)
	epatch ${FILESDIR}/do_munmap-fix.patch

	# Cobalt Patches
	if [ "${PROFILE_ARCH}" = "cobalt" ]; then
		echo -e ""
		einfo ">>> Patching kernel for Cobalt support ..."
		for x in ${WORKDIR}/cobalt-patches-24xx-${COBALTPATCHVER}/*.patch; do
			epatch ${x}
		done
		cp ${WORKDIR}/cobalt-patches-24xx-${COBALTPATCHVER}/cobalt-patches.txt ${S}
	fi

	kernel_universal_unpack
}
